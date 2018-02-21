local list = require('magma.list')

local function emptyListTest(it)
  local test = it('should create empty list')

  local function run(assert)
    local emptyList = list()

    return assert.is(emptyList.size, 0)
  end

  return test, run
end


return {
  name = 'list',
  tests = {
    emptyListTest,
  }
}
