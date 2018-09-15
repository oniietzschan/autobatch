if io then
  io.stdout:setvbuf("no")
end

function love.conf(t)
  t.window = false
end
