Zlist = require "zlist"

math.randomseed(os.time())

-- Create our list
local myList = Zlist(function(a, b) return a.z > b.z end)

-- Fill it with 10 objects with different values
for i = 1, 10 do
   local value = math.random(1, 10)
   myList:add({z = value})
end

-- Loop over all the objects in order
myList:forEach(function(obj)
   print(obj.z)
end)
