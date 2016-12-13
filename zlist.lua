local function add(self, object)
   local index       = #self.items + 1
   self.items[index] = object

   if self.points[0] == 0 then
      self.points[0] = 1
      self.points[1] = 0
   else
      local place   = 0
      local pointer = self.points[0]

      while pointer ~= 0 and self.sort(object, self.items[pointer]) do
         place   = pointer
         pointer = self.points[pointer]
      end

      self.points[index] = pointer
      self.points[place] = index
   end

   return self
end

local function clear(self)
   self.items   = {}
   self.points  = {[0] = 0}

   return self
end

local function forEach(self, func, ...)
   local next = self.points[0]
   while next > 0 do
      func(self.items[next], ...)
      next = self.points[next]
   end

   return self
end

local function cacheFunc(self, name, func)
   self[name] = function(...)
      local next = self.points[0]
      while next > 0 do
         func(self.items[next], ...)
         next = self.points[next]
      end
   end

   return self
end

local function new(sort)
   return {
      items   = {},
      points  = {[0] = 0},

      add       = add,
      clear     = clear,
      forEach   = forEach,
      cacheFunc = cacheFunc,

      sort = sort or function(a, b) return a.z > b.z end
   }
end

return setmetatable({
   new       = new,
   add       = add,
   clear     = clear,
   forEach   = forEach,
   cacheFunc = cacheFunc,
}, {
   __call = function(_, ...) return new(...) end,
})
