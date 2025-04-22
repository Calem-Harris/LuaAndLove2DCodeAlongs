if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    tick = require "tick";
    Object = require "classic";
    --require "shape";     -- Base Class
    local Rectangle = require "rectangle"; -- Inherited Class


    rectangle1 = Rectangle(100, 100, 200, 50); -- We are creating an instance of the Rectangle class
    rectangle2 = Rectangle(350, 80, 25, 140);
    --print(rectangle1.test, rectangle2.test);

    -- drawRectangle = false;

    -- tick.delay(function() drawRectangle = true end, 2)

    x = 30
    y = 50
    math.randomseed(os.time())
end

function love.update(dt)
    tick.update(dt)

    --rectangle1.update(rectangle1, dt)
    rectangle1:update(dt)
    rectangle2.update(rectangle2, dt)
end

function love.draw()
    --if drawRectangle then
    --love.graphics.rectangle("fill", x, y, 300, 200)
    --end

    rectangle1.draw(rectangle1)
    rectangle2.draw(rectangle2)
end

function love.keypressed(key)
    if key == "space" then
        x = math.random(100, 500)
        y = math.random(100, 500)
    end
end

--Sits at the bottom of our scripts
local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
