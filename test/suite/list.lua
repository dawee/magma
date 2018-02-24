local list = require('magma.list')

local function emptyListTest(it)
  local test = it('should create an empty list')

  local function run(assert)
    local emptyList = list()

    return assert.is(emptyList.size, 0)
  end

  return test, run
end

local function emptyListIterateTest(it)
  local test = it('should create an empty list and return done=true when trying to iterate')

  local function run(assert)
    local emptyList = list()
    local iterator = emptyList:iterator()
    local entry = iterator:next()

    return assert.is(entry.done, true)
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

local function pushIntoListIterateTest(it)
  local test = it('should push one entry into list and return the entry when iterating once')

  local function run(assert)
    local fedList = list():push('foo')
    local iterator = fedList:iterator()
    local entry = iterator:next()

    return assert.all(
      assert.is(entry.done, false),
      assert.is(entry.value[1], 0),
      assert.is(entry.value[2], 'foo')
    )
  end

  return test, run
end

local function push2IntoListTest(it)
  local test = it('should push 2 entries into list')

  local function run(assert)
    local emptyList = list()
    local fedList = emptyList:push('foo'):push('bar')

    return assert.all(
      assert.is(emptyList.size, 0),
      assert.is(fedList.size, 2)
    )
  end

  return test, run
end

local function push10IntoListTest(it)
  local test = it('should push 10 entries into list')

  local function run(assert)
    local emptyList = list()
    local fedList = emptyList
      :push('foo1')
      :push('foo2')
      :push('foo3')
      :push('foo4')
      :push('foo5')
      :push('foo6')
      :push('foo7')
      :push('foo8')
      :push('foo9')
      :push('foo10')

    return assert.all(
      assert.is(emptyList.size, 0),
      assert.is(fedList.size, 10)
    )
  end

  return test, run
end


return {
  name = 'list',
  tests = {
    emptyListTest,
    emptyListIterateTest,
    pushIntoListTest,
    pushIntoListIterateTest,
    push2IntoListTest,
    push10IntoListTest,
  }
}
