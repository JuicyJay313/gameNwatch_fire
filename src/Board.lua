--[[
    -- Board Class -- 

    Author: Julien-Pier Gagnon

    Represents the board that intercepts the falling "victims" from hitting the ground.
    When an object collides with the top edge of the board, it is sent flying to 
    the next possible location of the board.

]]

Board = Class{}

function Board:init(characters)
    -- the starting location of the board is at the center
    self.x = VIRTUAL_WIDTH/ 2 - 37
    self.y = VIRTUAL_HEIGHT - 40

    -- the fixed dimensions of the board 
    -- it cannot be change since it has no impact on the game
    self.width = 74
    self.height = 8

    -- represents the middle position out of 3 positions (left, center, right)
    self.position = 2

    self.characters = characters

end

function Board:update(dt)
    if love.keyboard.wasPressed('left') and self.position > 1 then
        self.x = self.x - (VIRTUAL_WIDTH/ 4)
        self.position = self.position - 1
    elseif love.keyboard.wasPressed('right') and self.position < 3 then
        self.x = self.x + (VIRTUAL_WIDTH/ 4)
        self.position = self.position + 1
    end

    if love.keyboard.wasPressed('a') and self.position > 1 then
        self.x = self.x - (VIRTUAL_WIDTH/ 4)
        self.position = self.position - 1
    elseif love.keyboard.wasPressed('d') and self.position < 3 then
        self.x = self.x + (VIRTUAL_WIDTH/ 4)
        self.position = self.position + 1
    end

    
end

function Board:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end