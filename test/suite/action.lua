local action = require('magma.action')

local function actionsFromDTTest(it)
  local test = it('should create actions from dt')

  local function run(assert)
    local createActions = action.factory()
    local actions = createActions(0.16)
    local iterator = actions:iterator()
    local entry1 = iterator:next()

    return assert.all(
      assert.is(entry1.value[2].type, action.type.GAME_UPDATE),
      assert.is(entry1.value[2].dt, 0.16)
    )
  end

  return test, run
end

return {
  name = 'action',
  tests = {
    actionsFromDTTest,
  }
}
