if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    player = {
        x = 100,
        y = 100,
        radius = 25,
        speed = 200
    }

    player2 = {
        x = 300,
        y = 100,
        radius = 25,
        speed = 200
    }

    coins = {}

    score = 0
    score2 = 0

    shakeDuration = 0
    shakeWait = 0
    shakeOffset = { x = 0, y = 0 }

    screenCanvas = love.graphics.newCanvas(400, 600)

    for i = 1, 25 do
        table.insert(coins, {
            x = love.math.random(50, 650),
            y = love.math.random(50, 450),
            radius = 10,
            image = love.graphics.newImage("dollar.png")
        }
        )
    end
end

function checkCollision(p1, p2)
    local distance = math.sqrt((p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2)

    return distance < p1.radius + p2.radius
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    elseif love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed * dt
    elseif love.keyboard.isDown("down") then
        player.y = player.y + player.speed * dt
    end

    if love.keyboard.isDown("a") then
        player2.x = player2.x - player2.speed * dt
    elseif love.keyboard.isDown("d") then
        player2.x = player2.x + player2.speed * dt
    end

    if love.keyboard.isDown("w") then
        player2.y = player2.y - player2.speed * dt
    elseif love.keyboard.isDown("s") then
        player2.y = player2.y + player2.speed * dt
    end

    for i = #coins, 1, -1 do -- The safe way to remove items from a table we are iterating over
        if checkCollision(player, coins[i]) then
            table.remove(coins, i)
            player.radius = player.radius + 1
            score = score + 1
            shakeDuration = 0.5
        elseif checkCollision(player2, coins[i]) then
            table.remove(coins, i)
            player2.radius = player2.radius + 1
            score2 = score2 + 1
            shakeDuration = 0.5
        end
    end

    if shakeDuration > 0 then
        shakeDuration = shakeDuration - dt
        if shakeWait > 0 then
            shakeWait = shakeWait - dt
        else
            shakeWait = 0.05
            shakeOffset.x = love.math.random(-5, 5)
            shakeOffset.y = love.math.random(-5, 5)
        end
    end
end

function drawGame(focus)
    love.graphics.push()                                    -- Make a copy of the current state and push it onto the stack
    love.graphics.translate(-focus.x + 200, -focus.y + 300) -- This is our camera
    if shakeDuration > 0 then
        --Translate with a random number between -5 and 5
        --The second translate is going to be done based on the previous translate
        love.graphics.translate(shakeOffset.x, shakeOffset.y)
    end
    love.graphics.circle("line", player.x, player.y, player.radius)
    love.graphics.circle("line", player2.x, player2.y, player2.radius)


    for i, coin in ipairs(coins) do
        love.graphics.circle("line", coin.x, coin.y, coin.radius)
        love.graphics.draw(coin.image, coin.x, coin.y, 0,
            1, 1, coin.image:getWidth() / 2, coin.image:getHeight() / 2)
    end

    love.graphics.pop() -- Pull the copy of the state off the stack and apply it
end

function love.draw()
    love.graphics.setCanvas(screenCanvas) -- This is us drawing to canvas 2
    love.graphics.clear()                 -- We are clearing any previous drawings on canvas 2
    drawGame(player)                      -- We are drawing the game to canvas 2

    love.graphics.setCanvas()             -- This is us drawing to canvas 1
    love.graphics.draw(screenCanvas)      -- We are drawing an instance of canvas 2 to canvas 1

    love.graphics.setCanvas(screenCanvas) -- This is us drawing to canvas 2
    love.graphics.clear()                 -- We are clearing any previous drawings on canvas 2
    drawGame(player2)                     -- We are drawing the game to canvas 2 again

    love.graphics.setCanvas()             -- This is us drawing to canvas 1
    love.graphics.draw(screenCanvas, 400) -- We are drawing a second instance of canvas 2 to canvas 1

    love.graphics.print("Player 1 Score: " .. score, 10, 10)
    love.graphics.print("Player 2 Score: " .. score2, 10, 30)
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
