local list = require('magma.list')

local function emptyListTest(it)
  local test = it('should create empty list')

  local function run(assert)
    local emptyList = list()

    return assert.is(emptyList.size, 0)
  end

  return test, run
end

local function pushIntoListTest(it)
  local test = it('should push one entry into list')

  local function run(assert)
    local emptyList = list()
    local fedList = emptyList:push('foo')

    return assert.all(
      assert.is(emptyList.size, 0),
      assert.is(fedList.size, 1)
    )
  end

  return test, run
end


return {
  name = 'list',
  tests = {
    emptyListTest,
    pushIntoListTest,
  }
}
