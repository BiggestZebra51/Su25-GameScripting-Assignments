-- Setup debugger, this goes at the very top of main
if arg[2] == "debug" then
    require("lldebugger").start()
end

-- Game where multiple images fall from sky
-- User clicks to send them back to top
-- Click images before they hit the bottom or game over

-- should have title screen, level 1, game over

function titleLoad()
    slimeIdle = love.graphics.newImage("sprites/slime/slime_idle.png")
    titleText = "Slime Drop"

    -- Update the window to be titled titleText
    love.window.setTitle(titleText)
end

--------------------------------------------------------------------------
-- Load
--
--------------------------------------------------------------------------
function love.load()
    --by default, love sets your window to 800x600
    success = love.window.updateMode(1024, 768)

    -- load title
    titleLoad()

    -- 0 = title screen
    -- 1 = game screen
    -- 2 = game over screen
    scene = 1

    slimeIdle = love.graphics.newImage("sprites/slime/slime_idle.png")
    slimeNums = 5 -- how many
    slimeX = {} -- Where at (x)
    slimeY = {} -- Where at (y)
    slimeSpeed = {} -- How fast
    minSpeed = 1
    maxSpeed = 20
    speedMod = 1
    count = slimeNums

    -- Randomization
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    -- Initially populate the slimes
    while count > 0 do
        slimeX[#slimeX+1] = math.random(0, love.graphics.getWidth() - slimeIdle:getWidth())
        -- get a random y value between 1 and 2 slimes above window
        slimeY[#slimeY+1] = 0 - math.random(slimeIdle:getHeight(), slimeIdle:getHeight()*2)
        -- get a random speed between min and max
        slimeSpeed[#slimeSpeed+1] = math.random(minSpeed, maxSpeed)

        count = count - 1 -- count down
    end
end

--------------------------------------------------------------------------
-- Click handling
-- 
--------------------------------------------------------------------------
function love.mousepressed(x, y, button, istouch)
    -- if it's left click
    if button == 1 then
        --if title screen
        if scene == 0 then
            --if on title screen
        end
        -- in game
        if scene == 1 then
            -- Check each image and see if it has collided with the mouse click
            for i, value in pairs(slimeX) do
                if x >= slimeX[i] and x <= slimeX[i] + slimeIdle:getWidth()
                   and y >= slimeY[i] and y <= slimeY[i] + slimeIdle:getHeight() then
                    -- send back to top and change speed
                    speedMod = speedMod + 1
                    maxSpeed = maxSpeed + speedMod

                    slimeX[i] = math.random(0, love.graphics.getWidth() - slimeIdle:getWidth())
                    -- get a random y value between 1 and 2 slimes above window
                    slimeY[i] = 0 - math.random(slimeIdle:getHeight(), slimeIdle:getHeight()*2)
                    -- get a random speed between min and max
                    slimeSpeed[i] = math.random(slimeSpeed[i], maxSpeed)

                    break
                end
            end
        end
    end
end

--------------------------------------------------------------------------
-- Update
-- 
--------------------------------------------------------------------------
function love.update(dt)
    -- GAMEPLAY
    if scene == 1 then
        for i, yPos in ipairs(slimeY) do
            if slimeY[i] + slimeIdle:getHeight() >= love.graphics.getHeight() then
                love.event.quit()
            end
            -- Move slimes
            slimeY[i] = yPos + (slimeSpeed[i] * dt)
        end
    end
end

--------------------------------------------------------------------------
-- Draw
-- 
--------------------------------------------------------------------------
function love.draw()
    -- TITLE SCREEN
    if scene == 0 then
        -- Draw the title screen
    end
    -- GAMEPLAY
    if scene == 1 then
        for i, xPos in ipairs(slimeX) do
            love.graphics.draw(slimeIdle, xPos, slimeY[i])
        end
    end
    -- GAMEOVER
    if scene == 2 then
        -- Draw the game over screen
    end
end

-- Setup error handler, Gives us highlighting of error issues allong with breakpoints
local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end