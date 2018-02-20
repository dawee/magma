local util = require('magma.util')
local emptyDict = require('magma.dict.empty')
local mergeIntoNode = require('magma.dict.node.merge')
local newValueNode = require('magma.dict.node.value')
local newArrayMapNode = require('magma.dict.node.arraymap')
local SIZE = require('magma.size')

local immutable = {}

local MAX_BITMAP_INDEXED_SIZE = SIZE / 2
local MIN_HASH_ARRAY_MAP_SIZE = SIZE / 4

function immutable.newDict()
  return emptyDict()
end

return immutable
