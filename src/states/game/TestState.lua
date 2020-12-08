TestState = Class{__includes = BaseState}

function TestState:init()
end

function TestState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end
function TestState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Testing", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
end