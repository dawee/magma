local list = require('magma.list')
local reduce = require('magma.reduce')

local function add(a, b)
  return a + b
end

local function sumTest(it)
  local test = it('should return the sum when predicate adds last result with current value')

  local function run(assert)
    local fedList = list({1, 2, 7, 10, 22})
    local sum = reduce(add, 0, fedList)

    return assert.is(sum, 42)
  end

  return test, run
end

return {
  name = 'reduce',
  tests = {
    sumTest
  }
}
