--[[
    Author: Julien-Pier Gagnon
    
    -- A list of dependencies that main.lua inherits --  
]]

-- the "push" library that allows the drawing of our game 
-- at a virtual resolution akin to a more retro aesthetic
-- https://github.com/Ulydev/push
push = require 'lib/push'

-- the "Class" library for lua
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

-- https://github.com/tst2005fork/lua-knife
Timer = require 'lib/knife.timer'

-- global constant variables
require 'src/constants'


require 'src/Util'

require 'src/Board'
require 'src/Rescuee'
require 'src/Animation'
require 'src/LevelParams'

require 'src/StateMachine'

require 'src/states/BaseState'
require 'src/states/game/TitleState'
require 'src/states/game/PlayState'
require 'src/states/game/HurtState'
require 'src/states/game/GameOverState'
require 'src/states/game/TestState'


gTextures = {
    ['rescuees'] = love.graphics.newImage('graphics/characterSprite32.png'),
    ['lostLives'] = love.graphics.newImage('graphics/lostLives.png'),
    ['background'] = love.graphics.newImage('graphics/background.png') -- **** placeholder ****
}

gFrames = {
    ['rescuees'] = GenerateQuads(gTextures['rescuees'], 32, 32),
    ['lostLives'] = GenerateQuads(gTextures['lostLives'], 32, 32)
}