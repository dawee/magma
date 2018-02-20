local newValueNode = require('magma.dict.node.value')
local util = require('magma.util')

local function newOwnerId()
  return {}
end

local function createNodes(ownerID, entries, key, value)
  if (not ownerID) then
    ownerID = newOwnerId()
  end

  local node = newValueNode(ownerID, util.hash(key), {key, value})
  local ii = 1

  while ii <= #entries do
    local entry = entries[ii];

    node = node:update(ownerID, 0, nil, entry[1], entry[2])
    ii = ii + 1
  end

  return node
end

return createNodes
