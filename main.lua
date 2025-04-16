if arg[2] == "debug" then
    require("lldebugger").start()
end

-- print("This how we send a message to our console log")
-- print(3)
-- print(3 + 4)

-- This is a comment. It will NOT be executed.
--Sits at the bottom of our scripts

-- local a = 3;
-- PascalCase = 4;
-- local third_var = a + PascalCase
-- a = 2;
-- PascalCase = -3
-- third_var = a + PascalCase

-- print(third_var)

-- local snake_case = 5; --This is best practice!
-- local snake_Case = 6; --This is a new, unique variable name

-- -- print(a + PascalCase)
-- -- print(a - PascalCase)
-- -- print(a * PascalCase)
-- -- print(a / PascalCase)
-- -- print(a ^ PascalCase)
-- -- print(a % PascalCase)

-- local name = "John Doe"
-- local age = "30"
-- local text = "My name is " .. name .. " and I am " .. age .. " years old."
-- print(text)

-- local test8 -- Good!
-- local te8st -- Good!
-- --local 8test -- Bad!

-- --@#$%^&* -- BAD! Don't put them in your variable names!

-- --FUNCTIONS
-- function Example(argument1, argument2)
--     --print("This is an example function" .. argument1 .. argument2)
--     return "This is an example function" .. argument1 .. argument2
-- end

-- a = Example(" Test", " Test2")
-- print(a)

-- example2 = function()
--     return "This is another example function"
-- end

-- PascalCase = example2()
-- print(PascalCase)

-- example2()

function love.load()
    --print("This is love.load")
    x_pos = 100
    y_pos = 200
    move_speed = 100
end

function love.update(delta_time)
    --print("This is love.update")

    if love.keyboard.isDown("right") then
        x_pos = x_pos + move_speed * delta_time
    end
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    --print("This is love.draw")

    love.graphics.rectangle("fill", x_pos, y_pos, 50, 80)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
