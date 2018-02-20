local updateDict = require('magma.dict.update')

local function dictGet(dict, k, notSetValue)
  if type(k) == 'table' then
    local index = 1
    local pointedValue = dict

    while index < #k and pointedValue do
      pointedValue = dictGet(pointedValue, k[index])
      index = index + 1
    end

    return dictGet(pointedValue, k[index])
  end

  if dict._root then
    return dict._root:get(0, undefined, k, notSetValue)
  else
    return notSetValue
  end
end

local function dictSet(dict, k, v, subindex)
  local emptyDict = require('magma.dict.empty')

  if type(k) == 'table' then
    local index = subindex or 1

    if index == #k then
      return dictSet(dict, k[#k], v)
    end

    local subdict = dictGet(dict, k[index]) or emptyDict()

    return dictSet(dict, k[index], dictSet(subdict, k, v, index + 1))
  end

  return updateDict(dict, k, v)
end

local function makeDict(size, root, ownerID, hash)
  local dict = {}

  dict.root = dict
  dict.set = dictSet
  dict.get = dictGet

  dict.size = size
  dict._root = root
  dict.__ownerID = ownerID
  dict.__hash = hash
  dict.__altered = false
  dict.__type = 'dict'

  return dict
end

return makeDict
