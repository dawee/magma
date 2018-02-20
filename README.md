# Magma

Functional programming library for [Löve](http://love2d.org).

## Immutable data structures

### dict

```lua
local dict = require('magma.dict')

local book1 = dict()
  :set('author', 'Lemony Snicket')
  :set('title', 'A Series Of Unfortunate Events 1')

local book2 = book1
  :set('title', 'A Series Of Unfortunate Events 2')

print('book1 title :', book1:get('title'))
-- A Series Of Unfortunate Events 1

print('book2 title :', book1:get('title'))
-- A Series Of Unfortunate Events 2
```
