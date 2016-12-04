local function add(self, object, z)
   local i = #self.numerical + 1
   self.numerical[i] = object
   self.zlist[i] = z

   if self.pointer == 0 then
      self.pointer = 1
      self.points[1] = 0
   else
      local place   = 0
      local pointer = self.pointer

      while pointer ~= 0 and self.zlist[pointer] < z do
         place = pointer
         pointer = self.points[pointer]
      end

      self.points[i] = pointer

      if place == 0 then
         self.pointer = i
      else
         self.points[place] = i
      end
   end
end

local function clear(self)
   self.numerical = {}
   self.zlist     = {}
   self.points    = {}
   self.pointer   = 0
end

local function forEach(self, func)
   local next = self.pointer
   while next ~= 0 do
      func(self.numerical[next])
      next = self.points[next]
   end
end

local function new()
   return {
      numerical = {},
      zlist     = {},
      points    = {},
      pointer   = 0,

      add     = add,
      clear   = clear,
      forEach = forEach,
   }
end

return setmetatable({
   new     = new,
   add     = add,
   clear   = clear,
   forEach = forEach,
}, {
   __call = new,
})
