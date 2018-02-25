local dict = require('magma.dict')
local mapValues = require('magma.mapvalues')

local function increment(value)
  return value + 1
end

local function mapValuesTest(it)
  local test = it('should return a new dict with transformed values')

  local function run(assert)
    local fedDict = dict({foo1 = 1, foo2 = 2})
    local mappedDict = mapValues(increment, fedDict)

    return assert.all(
      assert.is(mappedDict:get('foo1'), 2),
      assert.is(mappedDict:get('foo2'), 3)
    )
  end

  return test, run
end

return {
  name = 'mapValues',
  tests = {
    mapValuesTest
  }
}
