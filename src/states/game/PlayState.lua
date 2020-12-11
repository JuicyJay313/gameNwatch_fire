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
    self.goal = (self.levelParams.level) * 200      
end

function PlayState:update(dt)

    

    self.timer = self.timer + dt
    self.board:update(dt)

    -- If the player has reach the score goal of the current level,
    -- the level will stop spawning rescuees.
    if self.score < self.goal then
        if self.timer > self.levelParams.delay then
           table.insert(self.rescuees, Rescuee(math.random(3)))
           self.timer = 0
        end
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
                lostLives = self.lostLives,
                goal = self.goal
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

    -- Triggers a level change if the player reached the score goal and
    -- saved the remaining rescuees
    if self.score >= self.goal and #self.rescuees < 1 then
        gStateMachine:change('change', {
            score = self.score,
            lostLives = self.lostLives,
            board = self.board
        })
    end


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
    displayLostLives(self.lostLives)
end
