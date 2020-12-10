--[[
    -- Title Screen State -- 

    Author: Julien-Pier Gagnon

    Represents the screen with which the player is introduced to the game.
    It only has the title of the game, an appropriate song and few menu options
    that leads to other game states.
]]

TitleState = Class{__includes = BaseState}

function TitleState:init()
    self.board = Board(1)
    self.rescuees = {}
    self.score = 0
    self.lostLives = {}
    
end

function TitleState:update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('change', {
            board = self.board,
            rescuees = self.rescuees,
            score = self.score,
            lostLives = self.lostLives
        })
    end
end

function TitleState:render()

    love.graphics.printf('Hello Fire!', 0, VIRTUAL_HEIGHT/2 - 6, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press ENTER to play', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')
    displayScore(self.score)

end