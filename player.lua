local Object = require "classic"
local Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("Images/panda.png")
    self.x = 300
    self.y = 20
    self.speed = 500
    self.width = self.image:getWidth()
end

function Player:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
        print("x: " .. self.x)
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
        print("x: " .. self.x)
    end

    local window_width = love.graphics.getWidth()

    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
    end
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Player
