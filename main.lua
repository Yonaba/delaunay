-- ==================================
-- Demo for Delaunay.lua (v0.1)
-- (c)2013 Roland Y., MIT License
-- Compatible with Löve 0.9.0
-- ==================================

local Delaunay, Point
local points, triangles
local drawTriangles, drawPoints
local gen_time, get_time
local unpack = unpack

function love.load()
  
  Delaunay = require "lib.delaunay"
  Point    = Delaunay.Point
  
  -- Draws a set of triangles
  function drawTriangles(triangles)
    love.graphics.setColor(255, 0, 0, 255)
    for i,t in ipairs(triangles) do
      love.graphics.line(
        t.p1.x, t.p1.y,
        t.p2.x, t.p2.y,
        t.p3.x, t.p3.y,
        t.p1.x, t.p1.y
      )
    end   
  end
  
  -- Draws a set of points
  function drawPoints(points)
    love.graphics.setColor(255, 0, 0)
    for i,p in ipairs(points) do
      love.graphics.point(p.x, p.y)
    end   
  end
  
  -- Time the duration of function f
  function get_time(f, p)
    local start_time = love.timer.getTime()
    local result = f(unpack(p))
    return ((love.timer.getTime() - start_time) * 1000), result
  end
  
  
  triangles = {}
  points = {}
  gen_time = 0
  
  -- Sets point and line style
  love.graphics.setLineWidth(1)
  love.graphics.setLineStyle("smooth")
  love.graphics.setPointSize(10)
  love.graphics.setPointStyle("smooth")
  
end

function love.draw()
  drawPoints(points)
  drawTriangles(triangles)
  
  love.graphics.setColor(255, 255, 255)
  love.graphics.print('[LMB]: add a point', 10, 10)
  love.graphics.print('[RMB]: clear all points', 10, 25)
  
  love.graphics.print(('Count of vertices: %d'):format(#points), 10, 550)
  love.graphics.print(('Generated %d triangles in %.3f ms'):format(#triangles, gen_time), 10, 565)
  love.graphics.print(('Library version: v%s'):format(Delaunay._VERSION), 10, 580)

end

function love.mousepressed(x, y, b)
  if b == 'r' then
    points, triangles = {}, {} -- Clears all
  elseif b == 'l' then
    points[#points + 1] = Point(x, y) -- spawn a new point
  end
  -- Triangulates when we have enough vertices
  if #points >= 3 then
    gen_time, triangles = get_time(Delaunay.triangulate, points)
  end
end