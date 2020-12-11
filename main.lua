--[[
    Game & Watch: Fire remake

    Author: Julien-Pier Gagnon
    
    Originally developed by Nintendo in 1980 on a small dedicated handheld console designed 
    for a single game. It was later ported and remade in 1997 on the Game Boy handheld console 
    as part of a compilation titled "Game and Watch Gallery".

    This version is inspired by the GB remake from the compilation in terms of artstyle and resolution.
]]

require 'src/Dependencies'




function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Fire')

    math.randomseed(os.time())


    love.graphics.setFont(gFonts['medium'])

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['play'] = function() return PlayState() end,
        ['hurt'] = function() return HurtState() end,
        ['game over'] = function() return GameOverState() end,
        ['change'] = function() return ChangeLevelState() end
    }
    

    gStateMachine:change('title')

    love.keyboard.keysPressed = {}

end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    push:apply('start')

    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'],
        0, 0,
        0,
        VIRTUAL_WIDTH / (backgroundWidth - 1),
        VIRTUAL_HEIGHT / (backgroundHeight - 1)
    )


    gStateMachine:render()


    push:apply('end')
end

function displayScore(score)
    love.graphics.setFont(gFonts['medium'])

    love.graphics.print('Score: ', 5, 5)
    love.graphics.printf(tostring(score), 65, 5, 40, 'left')
end

function displayLevel(level)
    love.graphics.setFont(gFonts['medium'])

    love.graphics.print('Level: ', VIRTUAL_WIDTH/3, 5)
    love.graphics.printf(tostring(level), VIRTUAL_WIDTH/2, 5, 40, 'left')
end

function displayLostLives(lostLives)
    if #lostLives > 0 then
        local offset = (VIRTUAL_WIDTH - 5) - 32
        for y = 1, #lostLives do 
            love.graphics.draw(gTextures['lostLives'], gFrames['lostLives'][lostLives[y]], offset, 5)
            offset = offset - 32
        end 
    end
end
