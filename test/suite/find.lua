local find = require('magma.find')
local isBoolean = require('magma.isboolean')
local isDict = require('magma.isdict')
local isNumber = require('magma.isnumber')
local list = require('magma.list')
local dict = require('magma.dict')
local pipe = require('magma.pipe')
local push = require('magma.push')
local set = require('magma.set')

function pushFedDict(inputList)
  local fedDict = set('foo', 42, dict())

  return push(fedDict, inputList)
end

local createFedList = pipe(list, push('foo'), push(42), push('bar'), pushFedDict)

local function findInListUsingFunctionTest(it)
  local test = it('should return the value of the element found')

  local function run(assert)
    local fedList = createFedList()
    local found = find(isNumber, fedList)

    return assert.is(found, 42)
  end

  return test, run
end

local function noResultInListUsingFunctionTest(it)
  local test = it('should return nil if no element were found')

  local function run(assert)
    local fedList = createFedList()
    local found = find(isBoolean, fedList)

    return assert.is(found, nil)
  end

  return test, run
end

local function findInListUsingTableTest(it)
  local test = it('should return find element in list using key-value detection table')

  local function run(assert)
    local fedList = createFedList()
    local found = find({foo = 42}, fedList)

    return assert.is(isDict(found), true)
  end

  return test, run
end

local function noResultInListUsingTableTest(it)
  local test = it('should return nil if there is no element found in list using key-value detection table')

  local function run(assert)
    local fedList = createFedList()
    local found = find({foo = 0}, fedList)

    return assert.is(found, nil)
  end

  return test, run
end

return {
  name = 'find',
  tests = {
    findInListUsingFunctionTest,
    noResultInListUsingFunctionTest,
    findInListUsingTableTest,
    noResultInListUsingTableTest,
  }
}
