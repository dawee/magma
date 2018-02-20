local curry = require('magma.curry')

local function _set(keyPath, value, dict)
  if not dict or not dict.set then
    return dict
  end

  return dict:set(keyPath, value)
end

local set = curry(_set, 3)

return set
