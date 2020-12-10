--[[
    Author: Julien-Pier Gagnon

    -- Game Over State --

    Occurs when a player lost 3 lives. The player will be asked 
    to try again, enter a highscore if the player score ranked among the top 10
    or return to the title screen.
]]

GameOverState = Class{__include = BaseState}

local highlighted = 1

function GameOverState:init()
    
end

function GameOverState:enter(params)
    self.score = params.score     
end

function GameOverState:update(dt)
    
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if highlighted == 1 then
            gStateMachine:change('change', {
                board = Board(1),
                rescuees = {},
                score = 0,
                lostLives = {}
            })
        else    
            gStateMachine:change('title')
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("GAME OVER", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    if highlighted == 1 then
        love.graphics.setColor(1, 1, 103/255, 1)
    end
    love.graphics.printf("Retry", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then
        love.graphics.setColor(1, 1, 103/255, 1)
    end
    love.graphics.printf("Return to title screen", 0, VIRTUAL_HEIGHT / 2 + 15, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    displayScore(self.score)
end

function GameOverState:exit()
end