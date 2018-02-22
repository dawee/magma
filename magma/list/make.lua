local util = require('magma._util')
local ensureOwner = require('magma.list.owner')
local setListBounds = require('magma.list.bounds')

local function asMutable(list)
  return list.__ownerID and list or list:ensureOwner(util.newOwnerId())
end

local function withMutations(list, fn)
  local mutable = list:asMutable()

  fn(mutable)
  return mutable:wasAltered() and mutable:__ensureOwner(list.__ownerID) or list
end

local function push(list, ...)
  local values = {...}
  local oldSize = list.size

  local function mutate(newList)
    setListBounds(newList, 0, oldSize + #values);

    for ii = 1, #values do
      newList:set(oldSize + ii, values[ii])
    end
  end

  return list:withMutations(mutate)
end

local function makeList(origin, capacity, level, root, tail, ownerID, hash)
  local list = {
    size = capacity - origin,
    _origin = origin,
    _capacity = capacity,
    _level = level,
    _root = root,
    _tail = tail,
    __ownerID = ownerID,
    __hash = hash,
    __altered = false,
  }

  list.asMutable = asMutable
  list.ensureOwner = ensureOwner
  list.push = push
  list.withMutations = withMutations

  return list
end

return makeList
