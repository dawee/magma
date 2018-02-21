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

  return list
end

return makeList
