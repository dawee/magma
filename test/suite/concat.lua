local concat = require('magma.concat')
local list = require('magma.list')

local function concat2ListsTest(it)
  local test = it('should concat 2 lists and create a new one')

  local function run(assert)
    local concatList = concat(list():push('foo'), list():push('bar'):push(42))
    local iterator = concatList:iterator()
    local entry1 = iterator:next()
    local entry2 = iterator:next()
    local entry3 = iterator:next()

    return assert.all(
      assert.is(concatList.size, 3),
      assert.is(entry1.value[2], 'foo'),
      assert.is(entry2.value[2], 'bar'),
      assert.is(entry3.value[2], 42)
    )
  end

  return test, run
end

return {
  name = 'concat',
  tests = {
    concat2ListsTest,
  }
}
