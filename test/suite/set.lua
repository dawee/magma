local dict = require('magma.dict')
local set = require('magma.set')

local function setNewKeyTest(it)
  local test = it('should set a value into dict with a new key')

  local function run(assert)
    local setDict = set('foo', 42, dict())

    return assert.is(setDict:get('foo'), 42)
  end

  return test, run
end

local function setCurriedTest(it)
  local test = it('should set a value into dict using a curried function')

  local function run(assert)
    local setDict = set('foo')(42)(dict())

    return assert.is(setDict:get('foo'), 42)
  end

  return test, run
end

local function setUsingTableOfKeys(it)
  local test = it('should set a value into dict using a table of keys')

  local function run(assert)
    local setDict = set({'foo', 'bar'}, 42, dict())

    return assert.is(setDict:get('foo'):get('bar'), 42)
  end

  return test, run
end

local function setUsingKeyPath(it)
  local test = it('should set a value into dict using a key path')

  local function run(assert)
    local setDict = set('foo.bar', 42, dict())

    return assert.is(setDict:get('foo'):get('bar'), 42)
  end

  return test, run
end

return {
  name = 'set',
  tests = {
    setNewKeyTest,
    setCurriedTest,
    setUsingTableOfKeys,
    setUsingKeyPath,
  }
}
