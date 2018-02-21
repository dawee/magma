local function dictIteratorFrame(node, prev)
  return {
    node = node,
    index = 1,
    __prev = prev,
  }
end

local function iteratorDone()
  return {value = nil, done = true}
end

local function iteratorValue(k, v, iteratorResult)
  local value = {k, v}

  if iteratorResult then
    return value
  end

  return {value = value, done = false}
end

local function mapIteratorValue(entry)
  return iteratorValue(entry[1], entry[2])
end

local function next(iterator)
   local type = iterator._type
   local stack = iterator._stack

   while stack do
     local maxIndex
     local node = stack.node
     local index = stack.index;

     if node.entry then
       if index == 1 then
         return mapIteratorValue(node.entry)
       end
     else if node.entries then
       maxIndex = #node.entries + 1

       if (maxIndex - index) >= 1 then
         return mapIteratorValue(node.entries[iterator._reverse and (maxIndex - index) or index])
       end
     else
       maxIndex = #node.entries + 1

       if (maxIndex - index) >= 1 then
         local subNode = node.nodes[iterator._reverse and (maxIndex - index) or index]

         if subNode then
           if subNode.entry then
             return mapIteratorValue(subNode.entry)
           end

           iterator.stack = mapIteratorFrame(subNode, stack)
           stack = iterator.stack
         end

         goto continue
       end
     end

     iterator._stack = iterator._stack.__prev
     stack = iterator._stack

     ::continue::
     stack.index = stack.index + 1
   end

   return iteratorDone()
 end
end

local function newDictIterator(dict, reverse)
  local iterator = {
    _reverse = reverse,
    _stack = dict._root and dictIteratorFrame(dict._root)
  }

  iterator.next = next

  return iterator
end

return newDictIterator
