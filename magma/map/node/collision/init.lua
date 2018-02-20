local update = require('magma.map.node.collision.update')
local util = require('magma.util')

local function get(node, shift, keyHash, key, notSetValue)
  local entries = node.entries

  for __, entry in pairs(entries) do
    if util.is(key, entry[1]) then
      return entry[2]
    end
  end

  return notSetValue
end

local function newHashCollisionNode(ownerID, keyHash, entries)
  local node = {ownerID = ownerID, keyHash = keyHash, entries = entries}

  node.get = get
  node.update = update

  return node
end

return newHashCollisionNode
