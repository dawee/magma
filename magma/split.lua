local curry = require('magma.curry')

local function _split(pat, str)
   local t = {n = 0}
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)

   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end

   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end

   return t
end

local split = curry(_split, 2)

return split
