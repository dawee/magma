local updateMap = require('magma.map.update')

local function mapGet(map, k, notSetValue)
  if type(k) == 'table' then
    local index = 1
    local pointedValue = map

    while index < #k and pointedValue do
      pointedValue = mapGet(pointedValue, k[index])
      index = index + 1
    end

    return mapGet(pointedValue, k[index])
  end

  if map._root then
    return map._root:get(0, undefined, k, notSetValue)
  else
    return notSetValue
  end
end

local function mapSet(map, k, v, subindex)
  local emptyMap = require('magma.map.empty')

  if type(k) == 'table' then
    local index = subindex or 1

    if index == #k then
      return mapSet(map, k[#k], v)
    end

    local submap = mapGet(map, k[index]) or emptyMap()

    return mapSet(map, k[index], mapSet(submap, k, v, index + 1))
  end

  return updateMap(map, k, v)
end

local function makeMap(size, root, ownerID, hash)
  local map = {}

  map.root = map
  map.set = mapSet
  map.get = mapGet

  map.size = size
  map._root = root
  map.__ownerID = ownerID
  map.__hash = hash
  map.__altered = false
  map.__type = 'map'

  return map
end

return makeMap
