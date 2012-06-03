local life = require 'life'
local world, font
local throttle = 0

function love.load()
  local grid = {
    {0,0,1,1,0,0,1,1,1,0,1,0},
    {0,1,0,0,0,0,1,0,1,0,0,0},
    {0,0,1,1,0,0,1,0,0,0,0,0},
    {0,0,1,0,0,0,0,0,0,1,0,0},
    {0,0,0,0,1,0,0,0,1,1,0,0},
    {0,0,0,1,1,0,0,0,0,0,0,0},
  }
  world = life.build(grid)
  font = love.graphics.newFont(20)
end
function love.update(dt)
  throttle = throttle + dt
  if throttle > 1 then
    world:update()
    throttle = throttle - 1
  end
end

function love.draw()
  love.graphics.setFont(font)
  love.graphics.print(world:plot(), 10, 10)
end
