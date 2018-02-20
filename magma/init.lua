local util = require('magma.util')
local emptyMap = require('magma.map.empty')
local mergeIntoNode = require('magma.map.node.merge')
local newValueNode = require('magma.map.node.value')
local newArrayMapNode = require('magma.map.node.arraymap')
local SIZE = require('magma.size')

local immutable = {}

local MAX_BITMAP_INDEXED_SIZE = SIZE / 2
local MIN_HASH_ARRAY_MAP_SIZE = SIZE / 4

function immutable.newMap()
  return emptyMap()
end

return immutable
