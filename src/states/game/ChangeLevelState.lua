--[[
    Author: Julien-Pier Gagnon

    -- Change Level State Class -- 
]]


ChangeLevelState = Class{__includes = BaseState}

function ChangeLevelState:init()
    self.levelLabelX = -80
end

function ChangeLevelState:enter(params)
    self.score = params.score
    self.levelParams = LevelParams(self.score)
    self.lostLives = params.lostLives
    self.board = params.board
    self.rescuees = {}

    Timer.tween(0.50, {
        [self] = {levelLabelX = VIRTUAL_WIDTH / 3 + 30}
    })
    :finish(function()
        Timer.after(1, function()
            Timer.tween(0.50, {
                [self] = {levelLabelX = VIRTUAL_WIDTH + 80}
            })
            :finish(function()
                gStateMachine:change('play', {
                    score = self.score,
                    board = self.board,
                    rescuees = self.rescuees,
                    lostLives = self.lostLives
                })
            end)
        end)
    end)
end

function ChangeLevelState:update(dt)
    Timer.update(dt)
end

function ChangeLevelState:render()

    self.board:render()
    displayScore(self.score)
    displayLostLives(self.lostLives)

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Level ' .. tostring(self.levelParams.level),
        self.levelLabelX, VIRTUAL_HEIGHT/2 - 20, VIRTUAL_WIDTH, 'left')
end