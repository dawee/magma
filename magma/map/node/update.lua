local newArrayMapNode = require('magma.map.node.arraymap')
local newValueNode = require('magma.map.node.value')
local util = require('magma.util')
local NOT_SET = require('magma.notset')

local function updateNode(
  node,
  ownerID,
  shift,
  keyHash,
  key,
  value,
  didChangeSize,
  didAlter
)
  if (not node) then
    if (value == NOT_SET) then
      return node
    end

    util.setRef(didAlter);
    util.setRef(didChangeSize);
    return newValueNode(ownerID, keyHash, {key, value});
  end

  return node:update(
    ownerID,
    shift,
    keyHash,
    key,
    value,
    didChangeSize,
    didAlter
  )
end

return updateNode
