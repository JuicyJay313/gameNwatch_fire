--[[
    Author: Julien-Pier Gagnon

    -- Utility class --

    Receives atlas and converts them into indivudual images
]]

function GenerateQuads(atlas, tileWidth, tileHeight)
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getWidth() / tileHeight

    local sheetCounter = 1
    local spriteSheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spriteSheet[sheetCounter] = 
                love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth, 
                tileHeight, atlas:getDimensions())
            sheetCounter =  sheetCounter + 1
        end
    end

    return spriteSheet
end