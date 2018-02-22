local dict = require('magma.dict')
local merge = require('magma.merge')

local function merge2Dicts(it)
  local test = it('should merge 2 dicts into new one')

  local function run(assert)
    local dict1 = dict():set('foo', 42):set('bar', 'baz')
    local dict2 = dict():set('foo', 'bar'):set('foobar', 42)
    local merged = merge(dict2, dict1)

    return assert.all(
      assert.is(merged:get('foo'), 'bar'),
      assert.is(merged:get('foobar'), 42),
      assert.is(merged:get('bar'), 'baz')
    )
  end

  return test, run
end

return {
  name = 'merge',
  tests = {
    merge2Dicts,
  }
}
