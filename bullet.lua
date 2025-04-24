local Object = require "classic"
local Bullet = Object:extend()

function Bullet:new(x, y)
    self.image = love.graphics.newImage("Images/bullet.png")
    self.x = x
    self.y = y
    self.speed = 700

    --The below properties are used for collision detection
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Bullet:checkCollision(obj)
    local a_left = self.x
    local a_right = self.x + self.width
    local a_top = self.y
    local a_bottom = self.y + self.height

    local b_left = obj.x
    local b_right = obj.x + obj.width
    local b_top = obj.y
    local b_bottom = obj.y + obj.height

    --If A's right side is further to the left than B's left side
    if a_right > b_left
        --And A's left side is further to the right than B's right sides
        and a_left < b_right
        --And A's bottom side is further to the bottom than B's top side
        and a_bottom > b_top
        --And A's top side is further to the top than B's bottom side
        and a_top < b_bottom then
        --There has been a collision
        self.dead = true

        if obj.speed < 0 then
            obj.speed = obj.speed - 50
        elseif obj.speed > 0 then
            obj.speed = obj.speed + 50
        end
    end

    -- return a_right > b_left
    --     and a_left < b_right
    --     and a_bottom > b_top
    --     and a_top < b_bottom
end

function Bullet:update(dt)
    self.y = self.y + self.speed * dt

    if self.y > love.graphics.getHeight() then
        love.load()
    end
end

function Bullet:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Bullet
