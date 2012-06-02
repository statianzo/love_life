require 'lunit'
local life = require 'life'
module('life_test', lunit.testcase, package.seeall)

local world, grid

function setup()
  grid = {
    {0,0,0,0},
    {0,0,0,0},
    {0,0,0,0}
  }
  world = life.build(grid)
end

function testGridGetsSet()
  assert_equal(grid, world.grid)
end

function testNoNeighbors()
  local result = world:neighbors(1,1)
  assert_equal(0, result)
end

function testOneNeighbor()
  grid[1][2] = 1
  local result = world:neighbors(1,1)
  assert_equal(1, result)
end

function testEightNeighbors()
  grid = {
    {1,1,1,0},
    {1,1,1,0},
    {1,1,1,0}
  }
  local world = life.build(grid)
  local result = world:neighbors(2,2)
  assert_equal(8, result)
end

function testZeroNeighborsDies()
  grid = {
    {0,0,0,0},
    {0,1,0,0},
    {0,0,0,0}
  }
  local world = life.build(grid)
  local result = world:nextState(2,2)
  assert_equal(0, result)
end

function testOneNeighborDies()
  grid = {
    {0,1,0,0},
    {0,1,0,0},
    {0,0,0,0}
  }
  local world = life.build(grid)
  local result = world:nextState(2,2)
  assert_equal(0, result)
end

function testTwoNeighborsLives()
  grid = {
    {0,1,0,0},
    {1,1,0,0},
    {0,0,0,0}
  }
  local world = life.build(grid)
  local result = world:nextState(2,2)
  assert_equal(1, result)
end

function testThreeNeighborsLives()
  grid = {
    {0,1,0,0},
    {1,1,0,0},
    {0,0,1,0}
  }
  local world = life.build(grid)
  local result = world:nextState(2,2)
  assert_equal(1, result)
end

function testThreeNeighborsBorn()
  grid = {
    {0,1,0,0},
    {1,0,0,0},
    {0,0,1,0}
  }
  local world = life.build(grid)
  local result = world:nextState(2,2)
  assert_equal(1, result)
end

function testTwoNeighborsNotBorn()
  grid = {
    {0,1,0,0},
    {1,0,0,0},
    {0,0,0,0}
  }
  local world = life.build(grid)
  local result = world:nextState(2,2)
  assert_equal(0, result)
end

function testUpdate()
  grid = {
    {0,1,0,1},
    {1,0,1,0},
    {0,0,0,0}
  }
  local world = life.build(grid)
  world:update()
  assert_equal(1, world.grid[2][2])
  assert_equal(1, world.grid[1][3])
  assert_equal(0, world.grid[1][1])
end

function testPlot()
  grid = {
    {0,1,0,1},
    {1,0,1,0},
    {0,0,0,0}
  }
  local expected = "0 1 0 1\n1 0 1 0\n0 0 0 0"
  local world = life.build(grid)
  local result = world:plot()
  assert_equal(expected, result)
end
