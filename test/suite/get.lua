local dict = require('magma.dict')
local get = require('magma.get')

local function getTest(it)
  local test = it('should get value from dict')

  local function run(assert)
    local fedDict = dict({foo = 'bar', bar = 42})

    return assert.all(
      assert.is(get('foo', fedDict), 'bar'),
      assert.is(get('bar', fedDict), 42)
    )
  end

  return test, run
end

local function getUsingKeyTableTest(it)
  local test = it('should get value from dict using key table')

  local function run(assert)
    local fedDict = dict({foo = dict({bar = 42, baz = 'foobar'})})

    return assert.all(
      assert.is(get({'foo', 'bar'}, fedDict), 42),
      assert.is(get({'foo', 'baz'}, fedDict), 'foobar')
    )
  end

  return test, run
end

local function getUsingKeyPathTest(it)
  local test = it('should get value from dict using key path string')

  local function run(assert)
    local fedDict = dict({foo = dict({bar = 42, baz = 'foobar'})})

    return assert.all(
      assert.is(get('foo.bar', fedDict), 42),
      assert.is(get('foo.baz', fedDict), 'foobar')
    )
  end

  return test, run
end

return {
  name = 'get',
  tests = {
    getTest,
    getUsingKeyTableTest,
    getUsingKeyPathTest
  }
}
