--[[
    Author: Julien-Pier Gagnon

    -- Level Parameters Class -- 

    Receives the players current score and determines a number of factors
    related to the current difficulty
]]


LevelParams = Class{}

function LevelParams:init(score)
    self.level = math.floor(score/200) + 1
    self.delay = math.max(0.5, 
        (4 - (self.level-1) * 0.1)
    )
end

function LevelParams:update(score)
    self.level = math.floor(score/200) + 1
end