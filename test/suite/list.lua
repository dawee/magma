local list = require('magma.list')

local function emptyListTest(it)
  local test = it('should create an empty list')

  local function run(assert)
    local emptyList = list()

    return assert.is(emptyList.size, 0)
  end

  return test, run
end

local function createListUsingKVTableTest(it)
  local test = it('should create a list and feed it using value table')

  local function run(assert)
    local fedList = list({'foo', 'bar'})
    local iterator = fedList:iterator()
    local entry1 = iterator:next()
    local entry2 = iterator:next()

    return assert.all(
      assert.is(entry1.value[2], 'foo'),
      assert.is(entry2.value[2], 'bar')
    )
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

local function pushIntoListIterateTwiceTest(it)
  local test = it('should push one entry into list and return done=true when iterating twice')

  local function run(assert)
    local fedList = list():push('foo')
    local iterator = fedList:iterator()

    iterator:next()

    local entry = iterator:next()

    return assert.is(entry.done, true)
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

local function push2IntoListIterateTest(it)
  local test = it('should push 2 entries into list and iterate over entries')

  local function run(assert)
    local fedList = list():push('foo'):push('bar')
    local iterator = fedList:iterator()
    local entry1 = iterator:next()
    local entry2 = iterator:next()
    local entry3 = iterator:next()

    return assert.all(
      assert.is(entry1.value[1], 0),
      assert.is(entry1.value[2], 'foo'),
      assert.is(entry2.value[1], 1),
      assert.is(entry2.value[2], 'bar'),
      assert.is(entry3.done, true)
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

local function push10IntoListIterateTest(it)
  local test = it('should push 10 entries into list and iterate over entries')

  local function run(assert)
    local fedList = list()
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

    local iterator = fedList:iterator()

    local entry1 = iterator:next()
    local entry2 = iterator:next()
    local entry3 = iterator:next()
    local entry4 = iterator:next()
    local entry5 = iterator:next()
    local entry6 = iterator:next()
    local entry7 = iterator:next()
    local entry8 = iterator:next()
    local entry9 = iterator:next()
    local entry10 = iterator:next()
    local entry11 = iterator:next()

    return assert.all(
      assert.is(entry1.value[1], 0),
      assert.is(entry1.value[2], 'foo1'),
      assert.is(entry2.value[1], 1),
      assert.is(entry2.value[2], 'foo2'),
      assert.is(entry3.value[1], 2),
      assert.is(entry3.value[2], 'foo3'),
      assert.is(entry4.value[1], 3),
      assert.is(entry4.value[2], 'foo4'),
      assert.is(entry5.value[1], 4),
      assert.is(entry5.value[2], 'foo5'),
      assert.is(entry6.value[1], 5),
      assert.is(entry6.value[2], 'foo6'),
      assert.is(entry7.value[1], 6),
      assert.is(entry7.value[2], 'foo7'),
      assert.is(entry8.value[1], 7),
      assert.is(entry8.value[2], 'foo8'),
      assert.is(entry9.value[1], 8),
      assert.is(entry9.value[2], 'foo9'),
      assert.is(entry10.value[1], 9),
      assert.is(entry10.value[2], 'foo10'),
      assert.is(entry11.done, true)
    )
  end

  return test, run
end


return {
  name = 'list',
  tests = {
    emptyListTest,
    emptyListIterateTest,
    createListUsingKVTableTest,
    pushIntoListTest,
    pushIntoListIterateTest,
    pushIntoListIterateTwiceTest,
    push2IntoListTest,
    push2IntoListIterateTest,
    push10IntoListTest,
    push10IntoListIterateTest,
  }
}
