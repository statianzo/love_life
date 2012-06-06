local exports = {}
local world = {}

function world.toroidalIndex(index, max)
  if index < 1 then
    return max
  elseif index > max then
    return 1
  end

  return index
end

function world:neighbors(r, c)
  local count = 0
  for rowi=r-1, r+1 do
    local row = self.grid[self.toroidalIndex(rowi, #self.grid)]
    for celli=c-1, c+1 do
      local cell = row[self.toroidalIndex(celli, #row)]
      if not (rowi == r and celli == c) then
        count = count + cell
      end
    end
  end

  return count
end

function world:nextState(r, c)
  local ncount = self:neighbors(r,c)
  if ncount == 2 then
    return self.grid[r][c]
  elseif ncount == 3 then
    return 1
  end

  return 0
end

function world:update()
  local nextGrid = {}
  for r=1, #self.grid do
    nextGrid[r] = {}
    for c=1, #self.grid[r] do
      nextGrid[r][c] = self:nextState(r,c)
    end
  end
  self.grid = nextGrid
end

function world:plot()
  local rows = {}
  for _,v in ipairs(self.grid) do
    table.insert(rows, table.concat(v, ' '))
  end

  return table.concat(rows, "\n")
end

function exports.build(grid)
  local built = {grid=grid}
  setmetatable(built, {__index=world})

  return built
end

return exports
