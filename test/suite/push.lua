local list = require('magma.list')
local push = require('magma.push')

local function pushValueIntoExisting(it)
  local test = it('should push entry on existing list')

  local function run(assert)
    local fedList = push('foo', list())
    local iterator = fedList:iterator()
    local entry = iterator:next()

    return assert.all(
      assert.is(fedList.size, 1),
      assert.is(entry.value[2], 'foo')
    )
  end

  return test, run
end

return {
  name = 'push',
  tests = {
    pushValueIntoExisting
  }
}
