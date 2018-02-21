local newArrayNode = require('magma.dict.node.array')
local updateNode = require('magma.dict.node.update')
local util = require('magma.util')
local NOT_SET = require('magma.notset')

local CHANGE_LENGTH = {value = false}
local DID_ALTER = {value = false}

local function updateDict(dict, k, v)
  local newRoot
  local newSize
  local makeDict = require('magma.dict.make')

  if not dict._root then
    if v == NOT_SET then
      return dict
    end

    newSize = 1;
    newRoot = newArrayNode(dict.__ownerID, {{k, v}})
  else
    local didChangeSize = util.makeRef(CHANGE_LENGTH)
    local didAlter = util.makeRef(DID_ALTER)

    newRoot = updateNode(
      dict._root,
      dict.__ownerID,
      0,
      nil,
      k,
      v,
      didChangeSize,
      didAlter
    )

    if (not didAlter.value) then
      return dict
    end

    newSize = dict.size + (didChangeSize.value and (v == NOT_SET and -1 or 1) or 0);
  end

  if (dict.__ownerID) then
    dict.size = newSize
    dict._root = newRoot
    dict.__hash = undefined
    dict.__altered = true
    return dict
  end

  return newRoot and makeDict(newSize, newRoot) or emptyDict()
end

return updateDict
