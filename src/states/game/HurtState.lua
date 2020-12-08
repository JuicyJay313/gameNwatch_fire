--[[
    -- Hurt State --
    
    Author: Julien-Pier Gagnon

    A state that occurs when a rescuee falls below the players board. 
    The rescuee is seen hurt on the ground while a emergency emerges to 
    take it out of the screen. The table of rescuees is reset and the 
    player loses a 'life'. This state transitions into the PlayState if
    the player has remaining lives or the GameOver State if there is none left.
]]

HurtState = Class{__includes = BaseState}

function HurtState:enter(params)
    self.toAnimate = params.toAnimate
    self.board = params.board
    self.score = params.score
    self.level = params.level
    self.lostLives = params.lostLives
    self.toAnimate.currentState = 'hurt'
    self.rescuees = {}
    

    Timer.tween(2, {
        [self.toAnimate] = { x = VIRTUAL_WIDTH + 32}
    })
    :finish(function()
        if #self.lostLives < 3 then
            gStateMachine:change('play', {
                rescuees = self.rescuees,
                board = self.board,
                score = self.score,
                lostLives = self.lostLives,
                level = self.level
            })
        else
            gStateMachine:change('game over', {
                score = self.score
            })
        end
    end)
end

function HurtState:update(dt)
    self.toAnimate:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function HurtState:render()
    self.toAnimate:render()
    self.board:render()
    displayScore(self.score)
    displayLevel(self.level)
    if #self.lostLives > 0 then
        local offset = (VIRTUAL_WIDTH - 5) - 32
        for y = 1, #self.lostLives do 
            love.graphics.draw(gTextures['lostLives'], gFrames['lostLives'][self.lostLives[y]], offset, 5)
            offset = offset - 32
        end 
    end
end