local util = require('magma._util')
local getTailOffset = require('magma.list.tail')

local DONE = {}

local function next(iterator)
  local value = iterator.values()

  if value == DONE then
    return util.iteratorDone()
  end

  if iterator.reverse then
    iterator.index = iterator.index - 1
  else
    iterator.index = iterator.index + 1
  end

  return util.iteratorValue(type, iterator.index, value)
end

local function iterateList(list, reverse)
  local left = list._origin
  local right = list._capacity
  local tailPos = getTailOffset(right)
  local tail = list._tail
  local iterateLeaf, iterateNode

  local function iterateNodeOrLeaf(node, level, offset)
    if level == 0 then
      return iterateLeaf(node, offset)
    end

    return iterateNode(node, level, offset)
  end

  iterateLeaf = function (node, offset)
    local array

    if (offset == tailPos) then
      array = tail and tail.array
    else
      array = node and node.array
    end

    local from

    if offset > left then
      from = 0
    else
      from = left - offset
    end

    local to = right - offset

    if to > util.SIZE then
      to = util.SIZE
    end

    return function ()
      if from == to then
        return DONE;
      end

      local idx

      if (reverse) then
        to = to - 1
        idx = to
      else
        from = from + 1
        idx = from
      end

      return array and array[idx]
    end
  end

  iterateNode = function(node, level, offset)
    local values
    local array = node and node.array

    local from

    if offset > left then
      from = 0
    else
      from = bit.arshift((left - offset), level)
    end

    local to = bit.arshift((right - offset), level) + 1

    if to > util.SIZE then
      to = util.SIZE
    end

    return function ()
      while true do
        if values then
          local value = values()

          if not (value == DONE) then
            return value
          end

          values = nil
        end

        if from == to then
          return DONE
        end

        local idx

        if (reverse) then
          to = to - 1
          idx = to
        else
          from = from + 1
          idx = from
        end

        values = iterateNodeOrLeaf(
          array and array[idx],
          level - util.SHIFT,
          offset + bit.lshift(idx, level)
        )
      end
    end
  end

  return iterateNodeOrLeaf(list._root, list._level, 0)
end

local function newListIterator(list, reverse)
  local iterator = {
    index = (reverse and list.size or 0),
    values = iterateList(list, reverse)
  }

  iterator.next = next

  return iterator
end

return newListIterator