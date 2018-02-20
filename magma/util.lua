local util = {}

local stringHashCache = {}

local STRING_HASH_CACHE_MIN_STRLEN = 16
local STRING_HASH_CACHE_MAX_SIZE = 255
local STRING_HASH_CACHE_SIZE = 0

function util.is(valueA, valueB)
  return valueA == valueB
end

function util.makeRef(ref)
  ref.value = false
  return ref
end

function util.setRef(ref)
  if ref then
    ref.value = true
  end
end

function util.arrCopy(tab)
  return {unpack(tab)}
end

function util.setAt(array, idx, val, canEdit)
  local newArray = canEdit and array or util.arrCopy(array)

  newArray[idx] = val
  return newArray
end

function util.smi(i32)
  return bit.bor(bit.band(bit.rshift(i32, 1), 0x40000000), bit.band(i32, 0xbfffffff))
end

function util.hashString(string)
  local ii = 1
  local hashed = 0

  while ii <= string:len() do
    hashed = (31 * hashed + bit.bor(string.byte(string:sub(ii, ii)), 0))
    ii = ii + 1
  end

  return util.smi(hashed)
end

function util.cachedHashString(string)
  local hashed = stringHashCache[string]

  if hashed == nil then
    hashed = util.hashString(string)

    if STRING_HASH_CACHE_SIZE == STRING_HASH_CACHE_MAX_SIZE then
      STRING_HASH_CACHE_SIZE = 0
      stringHashCache = {}
    end

    STRING_HASH_CACHE_SIZE = STRING_HASH_CACHE_SIZE + 1
    stringHashCache[string] = hashed
  end

  return hashed
end

function util.hash(o)
  if (o == false) or (o == nil) then
    return 0
  end

  if o == true then
    return 1
  end

  if (type(o) == 'number') then
    local h = bit.bor(o, 0)

    if not (h == o) then
      h = h ^ (o * 0xffffffff)
    end

    while (o > 0xffffffff) do
      o = o / 0xffffffff
      h = h ^ o
    end

    return smi(h)
  end

  if (type(o) == 'string') then
    if o:len() > STRING_HASH_CACHE_MIN_STRLEN then
      return util.cachedHashString(o)
    else
      return util.hashString(o)
    end
  end

  if type(o.hashCode) == 'function' then
    -- Drop any high bits from accidentally long hash codes.
    return smi(o:hashCode())
  end

  -- @TODO throw that :
  print('Value type ' .. type(o) .. ' cannot be hashed.')
end

return util
