function join_path(left, right)
  return left .. '/' .. right
end

function append_path(left, right)
  return left .. ';' .. right
end

function love.conf(conf)
  local root = love.filesystem.getWorkingDirectory()

  package.path = join_path(root, '?.lua')
  package.path = append_path(package.path, join_path(root, '?/init.lua'))
  conf.window = nil
end
