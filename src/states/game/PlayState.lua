--[[
    -- Play State --

    Author: Julien-Pier Gagnon

    This is where the core of the game happens. 

]]

PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.ambulance = {x = 50, y = VIRTUAL_HEIGHT/2 + 10} -- change
    self.timer = 0
end


function PlayState:enter(params)
    self.board = params.board
    self.rescuees = params.rescuees
    self.score = params.score
    self.lostLives = params.lostLives
    self.levelParams = LevelParams(self.score)      
end

function PlayState:update(dt)

    

    self.timer = self.timer + dt
    self.board:update(dt)

    if self.timer > self.levelParams.delay then
        table.insert(self.rescuees, Rescuee(math.random(3)))
        self.timer = 0
    end

    
    
    for k, rescuee in pairs(self.rescuees) do
        rescuee:update(dt)
        if rescuee:collides(self.board) then
            self.score = self.score + (rescuee.type * 5)
            rescuee.dy = -3
            rescuee.dx = rescuee.dx - rescuee.dx/7 
            rescuee.gravity = rescuee.gravity + rescuee.gravity/9  
            rescuee.y = self.board.y - 32      
        end

        if rescuee.y > (self.board.y + 8) then
            rescuee.outBound = true
            table.insert(self.lostLives, rescuee.type)
            gStateMachine:change('hurt', {
                toAnimate = rescuee,
                board = self.board,
                score = self.score,
                level = self.levelParams.level,
                lostLives = self.lostLives
            })
        end

        if rescuee.x < self.ambulance.x and rescuee.y > self.ambulance.y then
            rescuee.outBound = true
            self.score = self.score + (rescuee.type * 10)
        end       
    end

    for k, rescuee in pairs(self.rescuees) do
        if rescuee.outBound then
            table.remove(self.rescuees, k)
        end
    end

    self.levelParams:update(self.score)


    
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    for k, rescuee in pairs(self.rescuees) do
        rescuee:render()
    end

    self.board:render()
    displayScore(self.score)
    displayLevel(self.levelParams.level)

    -- ***** add a function displayLostLives in main.lua *****
    if #self.lostLives > 0 then
        local offset = (VIRTUAL_WIDTH - 5) - 32
        for y = 1, #self.lostLives do 
            love.graphics.draw(gTextures['lostLives'], gFrames['lostLives'][self.lostLives[y]], offset, 5)
            offset = offset - 32
        end 
    end
end
