local util = require('magma._util')

local function removeBefore(vnode, ownerID, level, index)
  local newVNode = require('magma.list.vnode')

  if (((index == level) and bit.lshift(1, level) or 0) or #vnode.array == 0) then
    return vnode
  end

  local originIndex = bit.band(bit.rshift(index, level), util.MASK)

  if originIndex > #vnode.array then
    return newVNode({}, ownerID)
  end

  local removingFirst = (originIndex == 1)

  local newChild

  if level > 0 then
    local oldChild = vnode.array[originIndex]

    newChild = oldChild and oldChild:removeBefore(ownerID, level - util.SHIFT, index)

    if (newChild == oldChild) and removingFirst then
      return vnode
    end
  end

  if removingFirst and not newChild then
    return vnode
  end

  local editable = editableVNode(vnode, ownerID)

  if not removingFirst then
    for ii = 1, originIndex do
      editable.array[ii] = nil
    end
  end

  if newChild then
    editable.array[originIndex] = newChild
  end

  return editable;
end

return removeBefore
