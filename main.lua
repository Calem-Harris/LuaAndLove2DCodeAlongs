if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    local Player = require "player"
    local Enemy = require "enemy"
    --my_image = love.graphics.newImage("Images/sheep.png") -- This is how we load an image
    love.graphics.setBackgroundColor(0, 0, 0)

    player = Player() -- Creating an instance of our player
    enemy = Enemy()
end

function love.update(dt)
    --r1.x = r1.x + 100 * dt
    player:update(dt)
    enemy:update(dt)
end

local function checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    --If A's right side is further to the left than B's left side
    if a_right > b_left
        --And A's left side is further to the right than B's right sides
        and a_left < b_right
        --And A's bottom side is further to the bottom than B's top side
        and a_bottom > b_top
        --And A's top side is further to the top than B's bottom side
        and a_top < b_bottom then
        --There has been a collision
        return true
    else
        --At least one of the above statements was false
        return false
    end

    -- return a_right > b_left
    --     and a_left < b_right
    --     and a_bottom > b_top
    --     and a_top < b_bottom
end

function love.draw()
    player:draw()
    enemy:draw()
    -- local mode
    -- if checkCollision(r1, r2) then
    --     mode = "fill"
    -- else
    --     mode = "line"
    -- end
    -- love.graphics.rectangle(mode, r1.x, r1.y, r1.width, r1.height)
    -- love.graphics.rectangle(mode, r2.x, r2.y, r2.width, r2.height)

    --love.graphics.setColor(255 / 255, 200 / 255, 40 / 255, 127 / 255) -- 1, 0.78, 0.15, 0.5
    --love.graphics.draw(my_image, 300, 300, 2, 2, 1, width / 2, height / 2)
    --love.graphics.print("Hello World!", 400, 400, 0, 1, 1, 0, 0, 0.5, 0)
    --love.graphics.setColor(1, 1, 1)

    --love.graphics.rectangle("fill", 100, 100, 200, 200)
end

function love.keypressed(key)

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
