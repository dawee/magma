local util = require('magma.util')
local mergeIntoNode = require('magma.dict.node.merge')
local NOT_SET = require('magma.notset')

local function valueNodeGet(node, shift, keyHash, key, notSetValue)
  if util.is(key, node.entry[1]) then
    return node.entry[2]
  else
    return notSetValue
  end
end

local function valueNodeUpdate(node, ownerID, shift, keyHash, key, value, didChangeSize, didAlter)
  local removed = value == NOT_SET
  local keyMatch = util.is(key, node.entry[1])

  if (keyMatch and value == node.entry[2] or removed) then
    return node;
  end

  util.setRef(didAlter)

  if removed then
    util.setRef(didChangeSize)
    return
  end

  if keyMatch then
    if ownerID and (ownerID == node.ownerID) then
      node.entry[2] = value
      return node
    end

    return newValueNode(ownerID, node.keyHash, {key, value})
  end

  util.setRef(didChangeSize)
  return mergeIntoNode(node, ownerID, shift, util.hash(key), {key, value})
end

local function newValueNode(ownerID, keyHash, entry)
  local node = {ownerID = ownerID, keyHash = keyHash, entry = entry}

  node.new = newValueNode
  node.get = valueNodeGet
  node.update = valueNodeUpdate

  return node
end

return newValueNode
