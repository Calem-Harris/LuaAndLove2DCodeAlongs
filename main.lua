if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    image = love.graphics.newImage("tileset.png")

    local image_width = image:getWidth()
    local image_height = image:getHeight()

    -- width = 32
    -- height = 32

    width = (image_width / 3) - 2
    height = (image_height / 2) - 2

    quads = {}
    for i = 0, 1 do
        for j = 0, 2 do
            table.insert(quads, love.graphics.newQuad(
                1 + j * (width + 2),
                1 + i * (height + 2),
                width, height,
                image_width, image_height))
        end
    end

    tilemap = { { 1, 6, 6, 2, 1, 6, 6, 2 },
        { 3, 0, 0, 4, 5, 0, 0, 3 },
        { 3, 0, 0, 0, 0, 0, 0, 3 },
        { 4, 2, 0, 0, 0, 0, 1, 5 },
        { 1, 5, 0, 0, 0, 0, 4, 2 },
        { 3, 0, 0, 0, 0, 0, 0, 3 },
        { 3, 0, 0, 1, 2, 0, 0, 3 },
        { 4, 6, 6, 5, 4, 6, 6, 5 } }
    -- 1 = Tile 0 = Empty Space
    --tilemap[1][3] -> What it looks like to access specific tiles

    colors = {
        { 1, 1, 1 }, -- 1
        { 1, 0, 0 }, -- 2
        { 1, 0, 1 }, -- 3
        { 0, 0, 1 }, -- 4
        { 0, 1, 1 }  -- 5
    }

    player = {
        image = love.graphics.newImage("player.png"),
        tile_x = 2,
        tile_y = 2
    }
end

function isEmpty(row, tile)
    return tilemap[tile][row] == 0
end

function love.update(dt)

end

function love.draw()
    for i, table in ipairs(tilemap) do       -- What table we are looking at
        for j, tile in ipairs(tilemap[i]) do -- What tile in the table we are looking at
            if tile ~= 0 then
                --love.graphics.setColor(colors[tile])
                --love.graphics.rectangle("fill", j * 25, i * 25, 25, 25)
                love.graphics.draw(image, quads[tile], j * width, i * height)
            end
        end
    end

    love.graphics.draw(player.image, player.tile_x * width, player.tile_y * height)
end

function love.keypressed(key)
    local x = player.tile_x
    local y = player.tile_y

    if key == "left" then
        x = x - 1
    elseif key == "right" then
        x = x + 1
    elseif key == "up" then
        y = y - 1
    elseif key == "down" then
        y = y + 1
    end

    if isEmpty(x, y) then
        player.tile_x = x
        player.tile_y = y
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
