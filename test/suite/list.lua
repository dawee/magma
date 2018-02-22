local list = require('magma.list')

local function emptyListTest(it)
  local test = it('should create empty list')

  local function run(assert)
    local emptyList = list()

    return assert.is(emptyList.size, 0)
  end

  return test, run
end

local function pushOneEntryTest(it)
  local test = it('should push one entry into list')

  local function run(assert)
    local fedList = list():push('foo')

    return assert.all(
      assert.is(fedList.size, 1),
      assert.is(fedList._tail.array[1], 'foo')
    )
  end

  return test, run
end


return {
  name = 'list',
  tests = {
    emptyListTest,
    pushOneEntryTest,
  }
}
