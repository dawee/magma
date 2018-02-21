# Magma

Functional programming library for [Löve](http://love2d.org).

## Immutable data structures

### dict

```lua
local dict = require('magma.dict')

local bookSeries = dict()
  :set('author', 'Lemony Snicket')
  :set('title', 'A Series Of Unfortunate Events')

local book1 = bookSeries
  :set('title', bookSeries:get('title') .. ': The Bad Beginning')

local book2 = bookSeries
  :set('title', bookSeries:get('title') .. ': The Reptile Room')

print('book1 title :', book1:get('title'))
-- A Series Of Unfortunate Events : The Bad Beginning

print('book2 title :', book2:get('title'))
-- A Series Of Unfortunate Events : The Reptile Room
```
