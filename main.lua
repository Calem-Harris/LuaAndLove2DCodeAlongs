if arg[2] == "debug" then
    require("lldebugger").start()
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