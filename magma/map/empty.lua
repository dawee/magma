local makeMap = require('magma.map.make')

local EMPTY_MAP

local function emptyMap()
  if not EMPTY_MAP then
    EMPTY_MAP = makeMap(0)
  end

  return EMPTY_MAP
end

return emptyMap
