local immutable = require('magma')

local suite = {name = 'Dict', tests = {}}

function suite.tests.dict1(it)
  local test = it('should create a new dict')

  local function run(assert)
    local dict = immutable.newDict()
    return assert.is(dict.__type, 'dict')
  end

  return test, run
end

function suite.tests.dict2(it)
  local test = it('should set a new dict with setted key')

  local function run(assert)
    local dict = immutable.newDict()
    local newDict = dict:set('foo', 'bar')

    return assert.all(
      assert.is(dict:get('foo'), nil),
      assert.is(newDict:get('foo'), 'bar')
    )
  end

  return test, run
end

function suite.tests.dict3(it)
  local test = it('should set a new dict with a modified key')

  local function run(assert)
    local dict = immutable.newDict():set('foo', 'bar')
    local newDict = dict:set('foo', 'baz')

    return assert.all(
      assert.is(dict:get('foo'), 'bar'),
      assert.is(newDict:get('foo'), 'baz')
    )
  end

  return test, run
end

function suite.tests.dict4(it)
  local test = it('should set a new dict as a value')

  local function run(assert)
    local dict = immutable.newDict():set('foo', immutable.newDict():set('bar', 'baz'))

    return assert.is(dict:get('foo'):get('bar'), 'baz')
  end

  return test, run
end

function suite.tests.dict5(it)
  local test = it('should get content using table')

  local function run(assert)
    local dict = immutable.newDict():set('foo', immutable.newDict():set('bar', 'baz'))

    return assert.is(dict:get({'foo', 'bar'}), 'baz')
  end

  return test, run
end

function suite.tests.dict6(it)
  local test = it('should set content using table')

  local function run(assert)
    local dict = immutable.newDict():set({'foo', 'bar', 'baz'}, 42)

    return assert.is(dict:get({'foo', 'bar', 'baz'}), 42)
  end

  return test, run
end

function suite.tests.dict7(it)
  local test = it('should set multiple keys')

  local function run(assert)
    local dict = immutable.newDict()
      :set('foo', 'bar')
      :set('bar', 'baz')
      :set('foobar', 42)

    return assert.all(
      assert.is(dict:get('foo'), 'bar'),
      assert.is(dict:get('bar'), 'baz'),
      assert.is(dict:get('foobar'), 42)
    )
  end

  return test, run
end

function suite.tests.dict8(it)
  local test = it('should set multiple keys and reset one')

  local function run(assert)
    local dict = immutable.newDict()
      :set('foo', 'bar')
      :set('bar', 'baz')
      :set('foobar', 42)
      :set('foo', 'barbaz')

    return assert.all(
      assert.is(dict:get('foo'), 'barbaz'),
      assert.is(dict:get('bar'), 'baz'),
      assert.is(dict:get('foobar'), 42)
    )
  end

  return test, run
end

function suite.tests.dict9(it)
  local test = it('should create large dicts of numbers')

  local function run(assert)
    local dict = immutable.newDict()
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
      assert.is(dict:get('foo1'), 1),
      assert.is(dict:get('foo2'), 2),
      assert.is(dict:get('foo3'), 3),
      assert.is(dict:get('foo4'), 4),
      assert.is(dict:get('foo5'), 5),
      assert.is(dict:get('foo6'), 6),
      assert.is(dict:get('foo7'), 7),
      assert.is(dict:get('foo8'), 8),
      assert.is(dict:get('foo9'), 9),
      assert.is(dict:get('foo10'), 10),
      assert.is(dict:get('foo11'), 11),
      assert.is(dict:get('foo12'), 12),
      assert.is(dict:get('foo13'), 13),
      assert.is(dict:get('foo14'), 14),
      assert.is(dict:get('foo15'), 15),
      assert.is(dict:get('foo16'), 16),
      assert.is(dict:get('foo17'), 17),
      assert.is(dict:get('foo18'), 18)
    )
  end

  return test, run
end

function suite.tests.dict10(it)
  local test = it('should create large dicts of strings')

  local function run(assert)
    local dict = immutable.newDict()
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
      assert.is(dict:get('foo1'), '1'),
      assert.is(dict:get('foo2'), '2'),
      assert.is(dict:get('foo3'), '3'),
      assert.is(dict:get('foo4'), '4'),
      assert.is(dict:get('foo5'), '5'),
      assert.is(dict:get('foo6'), '6'),
      assert.is(dict:get('foo7'), '7'),
      assert.is(dict:get('foo8'), '8'),
      assert.is(dict:get('foo9'), '9'),
      assert.is(dict:get('foo10'), '10'),
      assert.is(dict:get('foo11'), '11'),
      assert.is(dict:get('foo12'), '12'),
      assert.is(dict:get('foo13'), '13'),
      assert.is(dict:get('foo14'), '14'),
      assert.is(dict:get('foo15'), '15'),
      assert.is(dict:get('foo16'), '16'),
      assert.is(dict:get('foo17'), '17'),
      assert.is(dict:get('foo18'), '18')
    )
  end

  return test, run
end

function suite.tests.dict11(it)
  local test = it('should create large dicts of booleans')

  local function run(assert)
    local dict = immutable.newDict()
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
      assert.is(dict:get('foo1'), true),
      assert.is(dict:get('foo2'), false),
      assert.is(dict:get('foo3'), true),
      assert.is(dict:get('foo4'), false),
      assert.is(dict:get('foo5'), true),
      assert.is(dict:get('foo6'), false),
      assert.is(dict:get('foo7'), true),
      assert.is(dict:get('foo8'), false),
      assert.is(dict:get('foo9'), true),
      assert.is(dict:get('foo10'), false),
      assert.is(dict:get('foo11'), true),
      assert.is(dict:get('foo12'), false),
      assert.is(dict:get('foo13'), true),
      assert.is(dict:get('foo14'), false),
      assert.is(dict:get('foo15'), true),
      assert.is(dict:get('foo16'), false),
      assert.is(dict:get('foo17'), true),
      assert.is(dict:get('foo18'), false)
    )
  end

  return test, run
end

function suite.tests.dict10(it)
  local test = it('should create large dicts of large string keys')

  local function run(assert)
    local dict = immutable.newDict()
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
      assert.is(dict:get('this is a very large string for key1'), 1),
      assert.is(dict:get('this is a very large string for key2'), 2),
      assert.is(dict:get('this is a very large string for key3'), 3),
      assert.is(dict:get('this is a very large string for key4'), 4),
      assert.is(dict:get('this is a very large string for key5'), 5),
      assert.is(dict:get('this is a very large string for key6'), 6),
      assert.is(dict:get('this is a very large string for key7'), 7),
      assert.is(dict:get('this is a very large string for key8'), 8),
      assert.is(dict:get('this is a very large string for key9'), 9),
      assert.is(dict:get('this is a very large string for key10'), 10)
    )
  end

  return test, run
end


return suite