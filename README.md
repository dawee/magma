# Magma

Functional programming library for [Löve](http://love2d.org).

## Immutable data structures

### dict

```lua
local dict = require('magma.dict')
local get = require('magma.get')
local set = require('magma.set')

local bookSeries = dict({
  author = 'Lemony Snicket',
  title = 'A Series Of Unfortunate Events'
})

local getTitle = get('title')
local setTitle = set('title')
local book1 = setTitle(getTitle(bookSeries) .. ': The Bad Beginning')(bookSeries)
local book2 = setTitle(getTitle(bookSeries) .. ': The Reptile Room')(bookSeries)

print('series title ->', getTitle(bookSeries))
-- series title -> A Series Of Unfortunate Events : The Bad Beginning

print('book1 title ->', getTitle(book1))
-- book1 title -> A Series Of Unfortunate Events : The Bad Beginning

print('book2 title ->', getTitle(book2))
-- book1 title -> A Series Of Unfortunate Events : The Reptile Room
```
