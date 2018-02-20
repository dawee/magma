local immutable = require('magma')

local suite = {name = 'Map', tests = {}}

function suite.tests.map1(it)
  local test = it('should create a new map')

  local function run(assert)
    local map = immutable.newMap()
    return assert.is(map.__type, 'map')
  end

  return test, run
end

function suite.tests.map2(it)
  local test = it('should set a new map with setted key')

  local function run(assert)
    local map = immutable.newMap()
    local newMap = map:set('foo', 'bar')

    return assert.all(
      assert.is(map:get('foo'), nil),
      assert.is(newMap:get('foo'), 'bar')
    )
  end

  return test, run
end

function suite.tests.map3(it)
  local test = it('should set a new map with a modified key')

  local function run(assert)
    local map = immutable.newMap():set('foo', 'bar')
    local newMap = map:set('foo', 'baz')

    return assert.all(
      assert.is(map:get('foo'), 'bar'),
      assert.is(newMap:get('foo'), 'baz')
    )
  end

  return test, run
end

function suite.tests.map4(it)
  local test = it('should set a new map as a value')

  local function run(assert)
    local map = immutable.newMap():set('foo', immutable.newMap():set('bar', 'baz'))

    return assert.is(map:get('foo'):get('bar'), 'baz')
  end

  return test, run
end

function suite.tests.map5(it)
  local test = it('should get content using table')

  local function run(assert)
    local map = immutable.newMap():set('foo', immutable.newMap():set('bar', 'baz'))

    return assert.is(map:get({'foo', 'bar'}), 'baz')
  end

  return test, run
end

function suite.tests.map6(it)
  local test = it('should set content using table')

  local function run(assert)
    local map = immutable.newMap():set({'foo', 'bar', 'baz'}, 42)

    return assert.is(map:get({'foo', 'bar', 'baz'}), 42)
  end

  return test, run
end

function suite.tests.map7(it)
  local test = it('should set multiple keys')

  local function run(assert)
    local map = immutable.newMap()
      :set('foo', 'bar')
      :set('bar', 'baz')
      :set('foobar', 42)

    return assert.all(
      assert.is(map:get('foo'), 'bar'),
      assert.is(map:get('bar'), 'baz'),
      assert.is(map:get('foobar'), 42)
    )
  end

  return test, run
end

function suite.tests.map8(it)
  local test = it('should set multiple keys and reset one')

  local function run(assert)
    local map = immutable.newMap()
      :set('foo', 'bar')
      :set('bar', 'baz')
      :set('foobar', 42)
      :set('foo', 'barbaz')

    return assert.all(
      assert.is(map:get('foo'), 'barbaz'),
      assert.is(map:get('bar'), 'baz'),
      assert.is(map:get('foobar'), 42)
    )
  end

  return test, run
end

function suite.tests.map9(it)
  local test = it('should create large maps of numbers')

  local function run(assert)
    local map = immutable.newMap()
      :set('foo1', 1)
      :set('foo2', 2)
      :set('foo3', 3)
      :set('foo4', 4)
      :set('foo5', 5)
      :set('foo6', 6)
      :set('foo7', 7)
      :set('foo8', 8)
      :set('foo9', 9)
      :set('foo10', 10)
      :set('foo11', 11)
      :set('foo12', 12)
      :set('foo13', 13)
      :set('foo14', 14)
      :set('foo15', 15)
      :set('foo16', 16)
      :set('foo17', 17)
      :set('foo18', 18)

    return assert.all(
      assert.is(map:get('foo1'), 1),
      assert.is(map:get('foo2'), 2),
      assert.is(map:get('foo3'), 3),
      assert.is(map:get('foo4'), 4),
      assert.is(map:get('foo5'), 5),
      assert.is(map:get('foo6'), 6),
      assert.is(map:get('foo7'), 7),
      assert.is(map:get('foo8'), 8),
      assert.is(map:get('foo9'), 9),
      assert.is(map:get('foo10'), 10),
      assert.is(map:get('foo11'), 11),
      assert.is(map:get('foo12'), 12),
      assert.is(map:get('foo13'), 13),
      assert.is(map:get('foo14'), 14),
      assert.is(map:get('foo15'), 15),
      assert.is(map:get('foo16'), 16),
      assert.is(map:get('foo17'), 17),
      assert.is(map:get('foo18'), 18)
    )
  end

  return test, run
end

function suite.tests.map10(it)
  local test = it('should create large maps of strings')

  local function run(assert)
    local map = immutable.newMap()
      :set('foo1', '1')
      :set('foo2', '2')
      :set('foo3', '3')
      :set('foo4', '4')
      :set('foo5', '5')
      :set('foo6', '6')
      :set('foo7', '7')
      :set('foo8', '8')
      :set('foo9', '9')
      :set('foo10', '10')
      :set('foo11', '11')
      :set('foo12', '12')
      :set('foo13', '13')
      :set('foo14', '14')
      :set('foo15', '15')
      :set('foo16', '16')
      :set('foo17', '17')
      :set('foo18', '18')

    return assert.all(
      assert.is(map:get('foo1'), '1'),
      assert.is(map:get('foo2'), '2'),
      assert.is(map:get('foo3'), '3'),
      assert.is(map:get('foo4'), '4'),
      assert.is(map:get('foo5'), '5'),
      assert.is(map:get('foo6'), '6'),
      assert.is(map:get('foo7'), '7'),
      assert.is(map:get('foo8'), '8'),
      assert.is(map:get('foo9'), '9'),
      assert.is(map:get('foo10'), '10'),
      assert.is(map:get('foo11'), '11'),
      assert.is(map:get('foo12'), '12'),
      assert.is(map:get('foo13'), '13'),
      assert.is(map:get('foo14'), '14'),
      assert.is(map:get('foo15'), '15'),
      assert.is(map:get('foo16'), '16'),
      assert.is(map:get('foo17'), '17'),
      assert.is(map:get('foo18'), '18')
    )
  end

  return test, run
end

function suite.tests.map11(it)
  local test = it('should create large maps of booleans')

  local function run(assert)
    local map = immutable.newMap()
      :set('foo1', true)
      :set('foo2', false)
      :set('foo3', true)
      :set('foo4', false)
      :set('foo5', true)
      :set('foo6', false)
      :set('foo7', true)
      :set('foo8', false)
      :set('foo9', true)
      :set('foo10', false)
      :set('foo11', true)
      :set('foo12', false)
      :set('foo13', true)
      :set('foo14', false)
      :set('foo15', true)
      :set('foo16', false)
      :set('foo17', true)
      :set('foo18', false)

    return assert.all(
      assert.is(map:get('foo1'), true),
      assert.is(map:get('foo2'), false),
      assert.is(map:get('foo3'), true),
      assert.is(map:get('foo4'), false),
      assert.is(map:get('foo5'), true),
      assert.is(map:get('foo6'), false),
      assert.is(map:get('foo7'), true),
      assert.is(map:get('foo8'), false),
      assert.is(map:get('foo9'), true),
      assert.is(map:get('foo10'), false),
      assert.is(map:get('foo11'), true),
      assert.is(map:get('foo12'), false),
      assert.is(map:get('foo13'), true),
      assert.is(map:get('foo14'), false),
      assert.is(map:get('foo15'), true),
      assert.is(map:get('foo16'), false),
      assert.is(map:get('foo17'), true),
      assert.is(map:get('foo18'), false)
    )
  end

  return test, run
end

function suite.tests.map10(it)
  local test = it('should create large maps of large string keys')

  local function run(assert)
    local map = immutable.newMap()
      :set('this is a very large string for key1', 1)
      :set('this is a very large string for key2', 2)
      :set('this is a very large string for key3', 3)
      :set('this is a very large string for key4', 4)
      :set('this is a very large string for key5', 5)
      :set('this is a very large string for key6', 6)
      :set('this is a very large string for key7', 7)
      :set('this is a very large string for key8', 8)
      :set('this is a very large string for key9', 9)
      :set('this is a very large string for key10', 10)

    return assert.all(
      assert.is(map:get('this is a very large string for key1'), 1),
      assert.is(map:get('this is a very large string for key2'), 2),
      assert.is(map:get('this is a very large string for key3'), 3),
      assert.is(map:get('this is a very large string for key4'), 4),
      assert.is(map:get('this is a very large string for key5'), 5),
      assert.is(map:get('this is a very large string for key6'), 6),
      assert.is(map:get('this is a very large string for key7'), 7),
      assert.is(map:get('this is a very large string for key8'), 8),
      assert.is(map:get('this is a very large string for key9'), 9),
      assert.is(map:get('this is a very large string for key10'), 10)
    )
  end

  return test, run
end


return suite
