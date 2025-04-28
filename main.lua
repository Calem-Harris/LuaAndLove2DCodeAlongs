if arg[2] == "debug" then
    require("lldebugger").start()
end

function love.load()
    song = love.audio.newSource("song.ogg", "stream")
    song:setLooping(true) -- This will loop the song

    --Method 1: Play a song
    --love.audio.play(song)

    -- --Method 2: Play a song
    -- song:play()

    sfx = love.audio.newSource("sfx.ogg", "static")
end

function love.update(dt)

end

function love.draw()

end

function love.keypressed(key)
    if key == "space" then
        sfx:play()
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
