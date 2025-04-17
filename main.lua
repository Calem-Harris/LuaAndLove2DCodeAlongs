if arg[2] == "debug" then
    require("lldebugger").start()
end

require("example")

function love.load()
    fruits = { "apple", "banana" }
    table.insert(fruits, "pear") --Adding an element to the end of the table
    table.insert(fruits, "kiwi")
    table.remove(fruits, 2)

    fruits[1] = "Tomato"

    vegetables = {}
    root_vegetable = {}
    table.insert(vegetables, root_vegetable)
    table.insert(vegetables, "carrot")

    table_of_rectangles = {}
end

local function TestFunction()
    print("this is a test function")
end

local function CreateRect()
    rect = {}
    --rect["width"] = 100
    rect.x = 100
    rect.y = 100
    rect.width = 70
    rect.height = 90

    rect.speed = 200

    rect.ExampleFunction = function()
        print("this is an example")
    end

    function rect.ExampleFunction2()
        print("this is an example 2")
    end

    --Putting a new rectangle in our table
    table.insert(table_of_rectangles, rect)
    rect.ExampleFunction()
    rect.ExampleFunction2()
    TestFunction()
end



function love.keypressed(key) --This is a listener
    if key == "space" then
        CreateRect()
    end
end

local hello = require "example"

function love.update(dt)
    for i, rect in ipairs(table_of_rectangles) do
        rect.x = rect.x + rect.speed * dt
    end

    print(hello)
    hello = "|hello World"
    print(hello)
end

function love.draw()
    for i, rect in ipairs(table_of_rectangles) do
        love.graphics.rectangle("line", rect.x, rect.y, rect.width, rect.height)
    end


    -- love.graphics.print(fruits[1], 100, 100)
    -- love.graphics.print(fruits[2], 100, 200)
    -- love.graphics.print(fruits[3], 100, 300)

    -- for i = 1, #fruits do
    --     love.graphics.print(fruits[i], 100, 100 + i * 30)
    -- end

    -- for i = 6, 18, 4 do
    --     print(i)
    -- end

    --ipairs
    -- for i, v in ipairs(fruits) do
    --     --print(i, v)
    --     love.graphics.print(v, 100, 100 + i * 30)
    --     -- i = What element we are currently looking at
    --     -- v = fruits[i]
    -- end
end

-- for i = 18, 6, -1 do
--     print(i)
-- end

--Sits at the bottom of our scripts
local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
