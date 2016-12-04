zlist = require "zlist"

math.randomseed(os.time())

-- Create our list
local myList = zlist()

-- Fill it with 10 objects with different values
for i = 1, 10 do
   local value = math.random(1, 10)
   myList:add({value}, value)
end

-- Loop over all the objects in order
myList:forEach(function(obj)
   print(obj[1])
end)
