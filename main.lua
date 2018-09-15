local screenW, screenH, screenScale = 400, 300, 2

local Terebi = require 'terebi'
local origLoveGraphics = love.graphics
local catImage, cw, ch
local screen

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.graphics.setLineStyle('rough')

  love.window.setMode(screenW * screenScale, screenH * screenScale)
  require 'autobatch'
  catImage = love.graphics.newImage('demo/cats/cat.png')
  cw, ch = catImage:getDimensions()
  screen = Terebi.newScreen(screenW, screenH, screenScale)
end

function _helpDraw(label, lg, x, y)
  -- Print label text.
  lg.print(label, x, y - 25)

  -- Draw "target" draw destination box without translating.
  local translateX, translateY = 10, 20
  lg.setColor(0, 0, 0)
  origLoveGraphics.rectangle(
    'line',
    x + translateX - 2,
    y + translateY + 2,
    cw + 4,
    ch + 4
  )
  -- Translate, then draw image, should be centered in box.
  lg.push()
  lg.translate(translateX * 2, translateY * 2)
  lg.scale(1)
  lg.rotate(0)
  lg.translate(translateX * -1, translateY * -1)
  lg.setColor(255, 255, 255)
  lg.draw(catImage, x, y)
  lg.pop()
end

function love.draw()
  screen:draw(function()
    love.graphics.clear(200, 200, 200)
    _helpDraw('Untouched Love2d', origLoveGraphics, 30, 50)
    _helpDraw('autobatch.lua', love.graphics, 180, 50)
  end)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.push('quit')
  end
end
