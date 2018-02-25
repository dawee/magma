local each = require('magma.each')
local list = require('magma.list')

local function eachTest(it)
  local test = it('should call function for each element')

  local function run(assert)
    local counter = 0
    local function incrementCounter(value)
      counter = counter + value
    end

    each(incrementCounter, list({1, 2, 7, 10, 22}))

    return assert.is(counter, 42)
  end

  return test, run
end

return {
  name = 'each',
  tests = {
    eachTest
  }
}
