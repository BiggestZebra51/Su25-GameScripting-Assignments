-- Setup debugger, this goes at the very top of main
if arg[2] == "debug" then
    require("lldebugger").start()
end

-- Game where multiple images fall from sky
-- User clicks to send them back to top
-- Click images before they hit the bottom or game over

-- should have title screen, level 1, game over

function titleLoad()
    titleText = "UFO Drop"

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

    ufoSprite = love.graphics.newImage("sprites/ufo/ufo_green.png")
    ufoNums = 5 -- how many
    ufoX = {} -- Where at (x)
    ufoY = {} -- Where at (y)
    ufoSpeed = {} -- How fast

    minSpeed = 5        -- The min speed for the ufos to move
    maxSpeed = 20       -- The max speed for the ufos to move
    maxSpeedOffset = 1  -- The max speed + (this offset incremented each click)

    globalSpeedMod = 1  -- A multiplier to the global speed

    bombSprite = love.graphics.newImage("sprites/items/bomb.png")
    powerupVisible = false
    powerupX = 0 -- Where at (x)
    powerupY = 0 -- Where at (y)

    powerupCooldown = 3               -- The cool down before the powerup can spawn again
    powerupSpawnOffsetMax = 4         -- The max offset for the cooldown
    powerupSpawnOffset = 0            -- The randomized offset for the powerup spawn cooldown
    powerupLastActivatedTime = love.timer.getTime() -- The time the powerup was last activated

    -- Randomization
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    for i = 1, ufoNums, 1 do
        ufoX[#ufoX+1] = math.random(0, love.graphics.getWidth() - ufoSprite:getWidth())
        -- get a random y value between 1 and 2 ufos above window
        ufoY[#ufoY+1] = 0 - math.random(ufoSprite:getHeight(), ufoSprite:getHeight()*2)
        -- get a random speed between min and max
        ufoSpeed[#ufoSpeed+1] = math.random(minSpeed, maxSpeed)
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
            -- If the bomb was pressed, clear all ufos and re-randomize them
            if powerupVisible
                    and x >= powerupX and x <= powerupX + bombSprite:getWidth()
                    and y >= powerupY and y <= powerupY + bombSprite:getHeight() then

                powerupVisible = false -- Hide the powerup
                powerupLastActivatedTime = love.timer.getTime()         -- The time the powerup was last activated
                powerupSpawnOffset = math.random(powerupSpawnOffsetMax) -- Set the timer offset for next spawn

                -- send back to top and change speed
                maxSpeedOffset = maxSpeedOffset + 1
                maxSpeed = maxSpeed + maxSpeedOffset

                for i, value in pairs(ufoX) do
                        ufoX[i] = math.random(0, love.graphics.getWidth() - ufoSprite:getWidth())
                        -- get a random y value between 1 and 2 ufos above window
                        ufoY[i] = 0 - math.random(ufoSprite:getHeight(), ufoSprite:getHeight()*2)
                        -- get a random speed between min and max
                        ufoSpeed[i] = math.random(ufoSpeed[i], maxSpeed)
                end
            else
                -- Check each image and see if it has collided with the mouse click
                for i, value in pairs(ufoX) do
                    if x >= ufoX[i] and x <= ufoX[i] + ufoSprite:getWidth()
                    and y >= ufoY[i] and y <= ufoY[i] + ufoSprite:getHeight() then
                        -- send back to top and change speed
                        maxSpeedOffset = maxSpeedOffset + 1
                        maxSpeed = maxSpeed + maxSpeedOffset

                        ufoX[i] = math.random(0, love.graphics.getWidth() - ufoSprite:getWidth())
                        -- get a random y value between 1 and 2 ufos above window
                        ufoY[i] = 0 - math.random(ufoSprite:getHeight(), ufoSprite:getHeight()*2)
                        -- get a random speed between min and max
                        ufoSpeed[i] = math.random(ufoSpeed[i], maxSpeed)

                        break
                    end
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
        for i, yPos in ipairs(ufoY) do
            if ufoY[i] + ufoSprite:getHeight() >= love.graphics.getHeight() then
                love.event.quit()
            end
            -- Move ufos
            ufoY[i] = yPos + (ufoSpeed[i] * dt * globalSpeedMod)
        end

        local timeSinceActivated = love.timer.getTime() - powerupLastActivatedTime
        
        if timeSinceActivated > powerupCooldown then
            -- Hide the powerup after having been visible for (cooldown) seconds
            if powerupVisible then
                powerupVisible = false -- Hide the powerup
                powerupLastActivatedTime = love.timer.getTime()         -- The time the powerup was last activated
                powerupSpawnOffset = math.random(powerupSpawnOffsetMax) -- Set the timer offset for next spawn

            elseif timeSinceActivated > (powerupCooldown + powerupSpawnOffset) then 
                powerupX = math.random(0, love.graphics.getWidth() - bombSprite:getWidth())
                powerupY = math.random(0, love.graphics.getHeight() - bombSprite:getHeight())

                powerupVisible = true -- Show the powerup
                powerupLastActivatedTime = love.timer.getTime() -- The time the powerup was last activated
            end
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
        if powerupVisible then
            love.graphics.draw(bombSprite, powerupX, powerupY)
        end

        for i, xPos in ipairs(ufoX) do
            love.graphics.draw(ufoSprite, xPos, ufoY[i])
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