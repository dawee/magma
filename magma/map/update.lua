local newArrayMapNode = require('magma.map.node.arraymap')
local updateNode = require('magma.map.node.update')
local util = require('magma.util')
local NOT_SET = require('magma.notset')

local CHANGE_LENGTH = {value = false}
local DID_ALTER = {value = false}

local function updateMap(map, k, v)
  local newRoot
  local newSize
  local makeMap = require('magma.map.make')

  if not map._root then
    if v == NOT_SET then
      return map
    end

    newSize = 1;
    newRoot = newArrayMapNode(map.__ownerID, {{k, v}})
  else
    local didChangeSize = util.makeRef(CHANGE_LENGTH)
    local didAlter = util.makeRef(DID_ALTER)

    newRoot = updateNode(
      map._root,
      map.__ownerID,
      0,
      nil,
      k,
      v,
      didChangeSize,
      didAlter
    )

    if (not didAlter.value) then
      return map
    end

    newSize = map.size + (didChangeSize.value and (v == NOT_SET and -1 or 1) or 0);
  end

  if (map.__ownerID) then
    map.size = newSize
    map._root = newRoot
    map.__hash = undefined
    map.__altered = true
    return map
  end

  return newRoot and makeMap(newSize, newRoot) or emptyMap()
end

return updateMap
