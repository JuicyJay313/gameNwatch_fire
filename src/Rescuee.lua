--[[
    -- Rescuee Class -- 

    Author: Julien-Pier Gagnon

    Represents the person falling from the building caught on fire. 
    If intercepted by the player (board), the player scores points and 
    the rescuee then bounces to another location which there is 3 in total. 
    The last bounce has the rescuee safely land in an ambulance and awards the
    player with additionnal points. If a rescuee falls on the ground, the player
    loses a life and the amount of rescuee in play resets to zero. 

]]

Rescuee = Class{}

function Rescuee:init(type)
    self.x = VIRTUAL_WIDTH - 34
    self.y = VIRTUAL_HEIGHT / 4 - 10
    self.type = type
    self.currentState = 'falling'
    if self.type == 1 then
        self.dx = 50
        self.gravity = 145/100
        self.fallingAnimation = Animation {
            frames = {1, 2, 3, 4},
            interval = 0.2
        }
        self.hurtAnimation = Animation {
            frames = {5},
            1
        }
    elseif self.type == 2 then
        self.dx = 58
        self.gravity = 180/100
        self.fallingAnimation = Animation {
            frames = {6, 7, 8, 9},
            interval = 0.2
        }
        self.hurtAnimation = Animation {
            frames = {10},
            1
        }
    elseif self.type == 3 then
        self.dx = 68 
        self.gravity = 220/100
        self.fallingAnimation = Animation {
            frames = {11, 12, 13, 14},
            interval = 0.2
        }
        self.hurtAnimation = Animation {
            frames = {15},
            1
        }
    end

    self.width = 32
    self.height = 32

    -- will turn true if the rescuee falls on the floor or lands in the ambulance
    self.outBound = false

    self.dy = 0
 
end

function Rescuee:collides(board)

    if self.x > board.x + board.width or board.x > self.x + self.width then
        return false
    end

    if self.y > board.y + board.height or board.y > self.y + self.height then
        return false
    end

    return true

end

function Rescuee:update(dt)
  
    if self.currentState == 'falling' then
        self.fallingAnimation:update(dt)
        self.dy = self.dy + self.gravity * dt
        self.y = self.y + self.dy

        self.x = self.x - self.dx * dt
    elseif self.currentState == 'hurt' then
        self.hurtAnimation:update(dt)
    end

end

function Rescuee:render()
    if self.currentState == 'falling' then
        love.graphics.draw(gTextures['rescuees'], gFrames['rescuees'][self.fallingAnimation:getCurrentFrame()],
        self.x, self.y)
    elseif self.currentState == 'hurt' then
        love.graphics.draw(gTextures['rescuees'], gFrames['rescuees'][self.hurtAnimation:getCurrentFrame()],
        self.x, self.y)
    end
end


