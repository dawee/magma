local inspect = require('lib.inspect')

local console = {}
local state = {
  term = {
    line = 0,
    margin = 5,
    width = 800,
    lineHeight = 25,
    fontSize = 20,
    fontName = 'inconsolata',
    history = {},
    linesCount = 24
  },
  colors = {
    background = {44, 50, 60},
    normal = {171, 178, 191},
    info = {100, 148, 237}
  },
  fonts = {}
}

function console.load()
  state.fonts.inconsolata = love.graphics.newFont(
    'asset/font/inconsolata/Inconsolata-Regular.ttf',
    state.term.fontSize
  )
end

function console.log(message)
  local log = type(message) == 'string' and message or inspect(message)

  table.insert(state.term.history, {state.colors.normal, log})

  if #state.term.history == state.term.linesCount then
    table.remove(state.term.history, 1)
  end
end

function console.draw()
  love.graphics.setBackgroundColor(unpack(state.colors.background))
  love.graphics.setFont(state.fonts[state.term.fontName])

  for index, log in pairs(state.term.history) do
    love.graphics.printf(
      log,
      state.term.margin,
      state.term.margin + (index - 1) * state.term.lineHeight,
      state.term.width - state.term.margin * 2
    )
  end
end

return console
