local exports = {}
local world = {}

function world.neighbors(t, r, c)
  local count = 0
  for i=-1, 1 do
    local row = t.grid[r+i]
    if row then
      for j=-1, 1 do
        local cell = row[c+j]
        if cell and not (i == 0 and j == 0) then
          count = count + cell
        end
      end
    end
  end

  return count
end

function world.nextState(t, r, c)
  local ncount = t:neighbors(r,c)
  if ncount == 2 then
    return t.grid[r][c]
  elseif ncount == 3 then
    return 1
  end

  return 0
end

function world.update(t)
  local nextGrid = {}
  for r=1, #t.grid do
    nextGrid[r] = {}
    for c=1, #t.grid[r] do
      nextGrid[r][c] = t:nextState(r,c)
    end
  end
  t.grid = nextGrid
end

function world.plot(t)
  local rows = {}
  for _,v in ipairs(t.grid) do
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
