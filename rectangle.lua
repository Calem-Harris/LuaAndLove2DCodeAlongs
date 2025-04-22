local Shape = require "shape"               --Creating a local shape variable that holds the information of the shape.lua return

local Rectangle = Shape:extend()            -- This is what makes Rectangle a class

function Rectangle:new(x, y, width, height) -- Think of this as the constructor!
    --self.test = math.random(1, 1000)
    --Rectangle.test = math.random(1, 1000)
    Rectangle.super.new(self, x, y)

    self.width = width
    self.height = height
end

function Rectangle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Rectangle;
