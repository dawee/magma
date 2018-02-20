local util = require('magma.util')
local createNodes = require('magma.dict.node.create')
local SIZE = require('magma.size')
local NOT_SET = require('magma.notset')

local MAX_ARRAY_MAP_SIZE = SIZE / 4

local function arrayMapNodeGet(node, shift, keyHash, key, notSetValue)
  local entries = node.entries

  for ii = 1, #entries do
    if util.is(key, entries[ii][1]) then
      return entries[ii][2]
    end
  end

  return notSetValue
end

local function arrayMapNodeUpdate(node, ownerID, shift, keyHash, key, value, didChangeSize, didAlter)
  local removed = value == NOT_SET
  local entries = node.entries
  local idx = 1
  local len = #entries

  while idx <= len do
    if util.is(key, entries[idx][1]) then
      break
    end

    idx = idx + 1
  end

  local exists = idx <= len

  if (exists and (entries[idx][2] == value) or removed) then
    return node
  end

  util.setRef(didAlter)

  if removed or (not exists) then
    util.setRef(didChangeSize)
  end

  if (removed and (#entries == 1)) then
    return
  end

  if ((not exists) and (not removed) and (#entries >= MAX_ARRAY_MAP_SIZE)) then
    return createNodes(ownerID, entries, key, value)
  end

  local isEditable = ownerID and (ownerID == node.ownerID)
  local newEntries = isEditable and entries or util.arrCopy(entries)

  if exists then
    if removed then
      local removedEntry = newEntries[#newEntries]

      table.remove(newEntries, #newEntries)

      if not (idx == len) then
        newEntries[idx] = removedEntry
      end
    else
      newEntries[idx] = {key, value}
    end
  else
    newEntries[#newEntries + 1] = {key, value}
  end

  if (isEditable) then
    node.entries = newEntries;
    return node;
  end

  return node.constructor(ownerID, newEntries)
end

local function newArrayMapNode(ownerID, entries)
  local node = {ownerID = ownerID, entries = entries}

  node.constructor = newArrayMapNode
  node.get = arrayMapNodeGet
  node.update = arrayMapNodeUpdate

  return node
end

return newArrayMapNode