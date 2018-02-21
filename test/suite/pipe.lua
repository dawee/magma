local pipe = require('magma.pipe')
local concatWord = require('test.fixture.concatword')

local function call2Functions(it)
  local test = it('should call 2 functions in good order and return last result')

  local function run(assert)
    local sentence = pipe(
      concatWord('My'),
      concatWord('name'),
      concatWord('is'),
      concatWord('Paul')
    )('Hi !')

    return assert.is(sentence, 'Hi ! My name is Paul')
  end

  return test, run
end

return {
  name = 'pipe',
  tests = {
    call2Functions,
  }
}
