local function newVNode(array, ownerID)
  local vnode = {array = array, ownerID = ownerID}

  return vnode
end

return newVNode
