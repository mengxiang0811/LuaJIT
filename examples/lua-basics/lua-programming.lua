--long strings
do
    print("****Long Strings****")
    a = [[
    hello
    world
    ]]

    b = [===[
    hello
    world
    ]===]

    print(a)
    print(b)

    print([[
    one
    two
    three]])
    print("****End****")
end

--numerical constants
do
    print("****Numerical****")
    natural_number=314.16e-2
    print(natural_number)

    c = 0xff
    print("constant: 0xFF = " .. c)
    print("****End****")
end

--[[
this is a long comment
--]]

--Values and Types

--[[
Assignment: The assignment statement first evaluates all its expressions 
and only then are the assignments performed
--]]
do
    print("****Assignments****")
    x = 3
    y = 4
    z = 5
    print("Origin: x = " .. x .. ", y = " .. y .. ", z = " .. z)
    x, y, z= y, z, x
    print("After Assignment: x = " .. x .. ", y = " .. y .. ", z = " .. z)

    a = true
    b = false
    print(a)
    tostring(a)
    print("****End****")
end

--Arithmetic Operators
do
    print("****Arithmetic Operators****")
    print("3^2 = " .. 3^2)
    print("3 / 2 = " .. 3/2) --double real numbers
    print("4 % 2 = " .. 4%2)
    print("****End****")
end

--Relational Operators
do
    print("****Relational Operators****")
    print(0 ~= 0)
    print(0 == 0)

    local c = 0x10
    print(c)
    d = 10
    e = 10
    print(d == e)
    print("****End****")
end

--The Length Operator
do
    print("****Length Operators****")
    a = { "x", "y"; x = 1, [30] = 23; 45 }
    print(#a) --why 3???
    print("****End****")
end

--Loops
do
    print("****Loops****")
    print("In a while loop!")
    i = 1
    while i <= 10 do
        print(i)
        i = i + 1
    end
    print("In a for loop!")
    for i = 1, 10, 2 do
        print(i)
    end
    print("In a repeat loop!")
    i = 1
    repeat
        print(i)
        i = i + 1
    until i == 10
    print("****End****")
end

--if elseif else ...
do
    print("****IF ELSE****")
    time = 10
    if time < 9 then
        print("Early!")
    elseif time <= 10 then
        print("Not too late!")
    else
        print("Late")
    end
    print("****End****")
end
--Functions
print("****Functions****")
local f;
f = function ()
    local x = 1
    local g;
    g = function ()
        return x + 1
    end

    return g();
end

print(f())
print("****End****")

--Table
do
    print("****Table Operations****")
    print(_G['_G'] == _G)
    q = {}
    u = {['@!#'] = 'qbert', [q] = 1729, [6.28] = 'tau'}
    print(u[6.28])
    print(u[{}])
    print(u[q])
    print(u.fu)
    u.fu = 100
    print(u.fu)
    print(u['fu'])

    print("****Print all the Key,Val in the table****")
    for key, val in pairs(u) do
        print(key, val)
    end

    for key in pairs(u) do
        print(key)
    end
    
    for _, val in pairs(u) do
        print(val)
    end
    --Lists in Table
    v = {"hello", "world", "bye!"}
    for i = 1,#v do
        print(v[i])
    end
    print("****End****")
end

--Metatable and Metamethod
do
    print "****Metatable and Metamethod****"
    defaultFavs = {animal = 'gru', food = 'donuts'} 
    myFavs = {food = 'pizza'} 
    --setmetatable(myFavs, {__index = defaultFavs, __newindex = function (t, k, v) print(k,v) end}) 
    setmetatable(myFavs, {__index = defaultFavs}) 
    eatenBy = myFavs.animal
    print(eatenBy)
    myFavs.animal = "haha"
    eatenBy = myFavs.animal
    print(eatenBy)
    print(defaultFavs.animal)
    myFavs.newKey = "dog"
    print(myFavs.newKey)
end

do
    t = {}
    function t.__add(f1, f2) 
        newVec = {}
        newVec.x = f1.x + f2.x
        newVec.y = f1.y + f2.y
        return newVec
    end

    v1 = {x = 10, y = 20}
    v2 = {x = 1, y = 2}
    setmetatable(v1, t)
    setmetatable(v2, t)

    v3 = v1 + v2
    --v3 = t.__add(v1, v2)
    print(v3.x, v3.y)

    setmetatable(v3, getmetatable(v1))
    r = v3 + v3
    print(r.x, r.y)
    print("****End****")
end

--class-like tables and Inheritance
do
    print("****Class-like Tables and Inheritance****")
    Dog = {}

    function Dog:new()
        newObj = {sound = 'woof'}
        self.__index = self
        return setmetatable(newObj, self)
    end

    function Dog:makeSound()
        print('I say ' .. self.sound)
    end

    Dog1 = Dog:new()
    Dog1:makeSound()  -- 'I say woof'
    function Dog1:makeSound()
        print("Another Dog say " .. self.sound)
    end
    Dog2 = Dog1:new()
    Dog2:makeSound()  -- 'Another Dog say woof'

    function Dog2:new()
        newObj = {sound = "doggy"}
        self.__index = self
        return setmetatable(newObj, self)
    end

    Dog3 = Dog2:new()
    Dog3:makeSound()
    print("****End****")
end

--Modules
do
    print("****This chunk tells you how to import new module!****")
    local M = require("module")
    M.sayhello()
    --M.about() --Error call
    print("****End****")
end

--Functions: upvalue
do
    print("****Other Features of Functions****")
    function Test(n)
        local function foo()
            local function inner1()
                print(n)
            end
            local function inner2()
                n = n + 10
            end
            return inner1,inner2
        end
        return foo
    end
    t = Test(2015)
    f1,f2 = t()
    f1()        -- print 2015

    f2()
    f1()        -- print 2025

    g1,g2 = t()
    g1()        -- print 2025

    g2()
    g1()        -- print 2035

    f1()        -- print 2035
end

do
    print("Anonymous Functions!")
    a = {}
    local x = 10
    for i = 1,10 do
        local y = 0
        a[i] = function () y = y + i; return x + y end
    end

    for i =1,10 do
        print(a[i]())
    end
    print("****End****")
end
--Data Structures
do
    print("****Array****")
    --Array
    a = {4, 5, 1}
    table.insert(a, -2)
    table.sort(a)

    for key,val in ipairs(a) do
        print(a[key])
    end
    print("****End****")
end

--Standard Library
do
    --I/O
    print("****I/O Library****")
    f = io.open("test.txt", "w")
    print(type(f))
    line = io.read()
    f:write(line .. "\n")
    f:close()

    f = io.open("test.txt")
    line = f:read()
    print(line)
    f:close()
    print("****End****")
    --io.write(false) --error message
    --
    --Math
    print("****Match Library****")
    print("log(2) = " .. math.log(2))
    print("log10(10) = " .. math.log10(10))
    print("log10(e) = " .. math.log10(e))
    print(math.sqrt(144))
    print(math.random())
    print(math.random(100)) --returns a pseudo-random integer x, such that 1 ≤ x ≤ n
    print(math.random(5, 10)) --call random with two integer arguments, l and u, to get a pseudo-random integer x such that l ≤ x ≤ u.
    print("****End****")

    --String
    print("****String Library****")
    str = "hello world!"
    print("The length of the string: " .. str .. " is " .. string.len(str)) -- equivalent to #str
    print("To lower: " .. str:lower())
    print("To upper: " .. str:upper())
    print(string.sub(str, 5, 7))
    print(str:sub(5, 7))
    print(str:byte(2))
    --string.rep(s,n) (or s:rep(n)) returns the string s repeated n times.
    print(string.rep("cd", 5))
    --creates a table with the codes of all characters in str
    tbl = {str:byte(1,-1)}
    --recreate the original string
    --print(string.char(table.unpack(tbl))) --??

    --Function string.format is a powerful tool for formatting strings, typically for output.
    print(string.format("pi = %.4f", math.pi))
    d = 5; m = 11; y = 1990
    print(string.format("%02d/%02d/%04d", d, m, y))
    print("****End****")
end
