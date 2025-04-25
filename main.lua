if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    epsilon = 1

    circle = {}

    circle.x = 100
    circle.y = 100
    circle.radius = 25
    circle.speed = 200

    arrow = {}
    arrow.x = 200
    arrow.y = 200
    arrow.speed = 300
    arrow.angle = 0
    arrow.image = love.graphics.newImage("arrow_right.png")
    arrow.origin_x = arrow.image:getWidth() / 2
    arrow.origin_y = arrow.image:getHeight() / 2

    image = love.graphics.newImage("jump_2.png")
    width = image:getWidth()
    height = image:getHeight()

    frames = {}
    local frame_width = 117
    local frame_height = 233
    local maxFrames = 5
    for i = 0, 1 do     -- Rows of sprites
        for j = 0, 2 do -- Cutting out each sprite in the row
            if #frames == maxFrames then
                break
            end
            table.insert(frames, love.graphics.newQuad(j * frame_width, i * frame_height,
                frame_width, frame_height, width, height))
        end
    end

    -- for i = 0, 2 do
    --     table.insert(frames, love.graphics.newQuad(i * frame_width, 0, frame_width,
    --         frame_height, width, height))
    -- end

    -- for i = 0, 1 do
    --     table.insert(frames, love.graphics.newQuad(i * frame_width, frame_height, frame_width,
    --         frame_height, width, height))
    -- end

    -- table.insert(frames, love.graphics.newQuad(0, 0, frame_width, frame_height,
    --     image:getWidth(), image:getHeight()))

    -- table.insert(frames, love.graphics.newQuad(frame_width, 0, frame_width,
    --     frame_height, image:getWidth(), image:getHeight()))

    -- for i = 1, 5 do
    --     table.insert(frames, love.graphics.newImage("jump" .. i .. ".png"))
    -- end


    currentFrame = 1

    -- This is no longer needed because we are doing it more efficiently with a loop
    -- table.insert(frames, love.graphics.newImage("jump3.png"))
    -- table.insert(frames, love.graphics.newImage("jump4.png"))
    -- table.insert(frames, love.graphics.newImage("jump1.png"))
    -- table.insert(frames, love.graphics.newImage("jump5.png"))
    -- table.insert(frames, love.graphics.newImage("jump2.png"))
end

--Using Pythagorean theorem to calculate the distance between two points
function getDistance(x1, y1, x2, y2)
    local horizontal_distance = x1 - x2
    local vertical_distance = y1 - y2

    local a = horizontal_distance * horizontal_distance
    local b = vertical_distance * vertical_distance

    local c = a + b
    local distance = math.sqrt(c)
    return distance
end

function love.update(dt)
    currentFrame = currentFrame + 10 * dt
    if currentFrame >= 6 then
        currentFrame = 1
    end

    mouse_x, mouse_y = love.mouse.getPosition()

    arrow.angle = math.atan2(mouse_y - arrow.y, mouse_x - arrow.x)
    angle = math.atan2(mouse_y - circle.y, mouse_x - circle.x)

    cos = math.cos(angle)
    sin = math.sin(angle)
    arrowCos = math.cos(arrow.angle)
    arrowSin = math.sin(arrow.angle)

    local distance = getDistance(circle.x, circle.y, mouse_x, mouse_y)
    local arrowDistance = getDistance(arrow.x, arrow.y, mouse_x, mouse_y)

    --We want to not have the cirle move unless it is within a certain distance of the mouse
    if distance < 400 then
        --circle.x = circle.x + circle.speed * cos * (distance / 100) * dt
        --circle.y = circle.y + circle.speed * sin * (distance / 100) * dt
    end

    if arrowDistance > epsilon then
        arrow.x = arrow.x + arrow.speed * arrowCos * dt
        arrow.y = arrow.y + arrow.speed * arrowSin * dt
    end
end

function love.draw()
    love.graphics.draw(image, frames[math.floor(currentFrame)], 100, 100)

    -- love.graphics.draw(arrow.image, arrow.x, arrow.y, arrow.angle,
    --     1, 1, arrow.origin_x, arrow.origin_y)
    -- love.graphics.circle("fill", mouse_x, mouse_y, 5)

    -- love.graphics.circle("line", circle.x, circle.y, circle.radius)

    -- love.graphics.print("angle: " .. angle, 10, 10)

    -- love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
    -- love.graphics.line(circle.x, circle.y, mouse_x, circle.y)
    -- love.graphics.line(mouse_x, mouse_y, mouse_x, circle.y)

    -- local distance = getDistance(circle.x, circle.y, mouse_x, mouse_y)
    -- love.graphics.circle("line", circle.x, circle.y, distance)

    -- --There are to help visualize the velocities
    -- love.graphics.line(circle.x, circle.y, mouse_x, circle.y)
    -- love.graphics.line(circle.x, circle.y, circle.x, mouse_y)

    -- --The angle
    -- love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
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
