require 'luacov'
local make_assertion = (require "telescope").make_assertion
local Point          = (require "delaunay").Point
local Edge           = (require "delaunay").Edge
local Triangle       = (require "delaunay").Triangle

make_assertion("fuzzy_equal", "%s to be almost equal to %s", function(a, b)
 return math.abs(a - b) < 1e-8 
end)
 
context("Triangle", function()

  test('a triangle is created passing three Points', function()
    local t = Triangle(Point(), Point(2,0), Point(1,1))
    assert_equal(getmetatable(t), Triangle)
  end)
  
  test('a triangle has 3 Points as members : p1, p2 and p3', function()
    local p1, p2, p3 = Point(), Point(2,0), Point(1,1)
    local t = Triangle(p1, p2, p3)
    assert_equal(t.p1, p1)
    assert_equal(t.p2, p2)
    assert_equal(t.p3, p3)
  end)

  test('a triangle has also 3 Edges as members : e1, e2 and e3', function()
    local p1, p2, p3 = Point(), Point(2,0), Point(1,1)
    local t = Triangle(p1, p2, p3)
    assert_equal(t.e1, Edge(p1, p2))
    assert_equal(t.e2, Edge(p2, p3))
    assert_equal(t.e3, Edge(p3, p1))
  end)
  
  test('a triangle cannot have a flat angle', function()
    local p1, p2, p3 = Point(-1, 0), Point(0, 0), Point(1, 0)
    local p4, p5, p6 = Point(0, 1), Point(0, 0), Point(0, -1)
    local function makeFlat1() return Triangle(p1, p2, p3) end
    local function makeFlat2() return Triangle(p4, p5, p6) end
    assert_error(makeFlat1)
    assert_error(makeFlat2)
  end)  
  
  it('can evaluate the 3 sides length', function()
    local p1, p2, p3 = Point(), Point(2,0), Point(1,1)
    local t = Triangle(p1, p2, p3)
    local a, b, c = t:getSidesLength()
    assert_equal(a, 2)
    assert_equal(b, math.sqrt(2))
    assert_equal(c, math.sqrt(2))
  end)
  
  it('can evaluate the coordinates of the triangle center', function()
    local p1, p2, p3 = Point(-1,0), Point(1,0), Point(0,1)
    local t = Triangle(p1, p2, p3)
    local x, y = t:getCenter()
    assert_equal(x, 0)
    assert_equal(y, 1/3)
  end)

  it('can evaluate the coordinates of the triangle circumcenter', function()
    local p1, p2, p3 = Point(5, 5), Point(10, 3), Point(9, 15)
    local t = Triangle(p1, p2, p3)
    local x, y = t:getCircumCenter()
    assert_equal(x, 9.5)
    assert_equal(y, 9)
  end)
  
  it('can evaluate the radius of the triangle circumcircle', function()
    local p1, p2, p3 = Point(5, 5), Point(10, 3), Point(9, 15)
    local t = Triangle(p1, p2, p3)
    assert_fuzzy_equal(t:getCircumRadius(), 6.0207972893961)
  end)

  it('can evaluate both circumcenter and circumradius', function()
    local p1, p2, p3 = Point(5, 5), Point(10, 3), Point(9, 15)
    local t = Triangle(p1, p2, p3)
    local x, y, r = t:getCircumCircle()
    assert_equal(x, 9.5)
    assert_equal(y, 9)    
    assert_fuzzy_equal(t:getCircumRadius(), 6.0207972893961)
  end)
  
  it('can test if a given point lies in a triangle\'s circumcircle', function()
    local p1, p2, p3 = Point(0, 0.5), Point(1, 1), Point(1.01, 1.01)
    local t = Triangle(Point(-1,0), Point(1, 0), Point(1, 1))
    assert_true(t:inCircumCircle(p1))
    assert_true(t:inCircumCircle(p2))
    assert_false(t:inCircumCircle(p3))
  end)
  
  it('can evaluate the area of a triangle', function()
    local p1, p2, p3 = Point(), Point(1, 0), Point(1, 1)
    local t = Triangle(p1, p2, p3)
    local x, y, r = t:getCircumCircle()
    assert_equal(t:getArea(), 0.5)
  end)

  it('can evaluate if triangle is defined clockwise', function()
    local p1, p2, p3 = Point(), Point(-1, 0), Point(1, 1)
    assert_true((Triangle(p1, p2, p3)):isCW())
    assert_false((Triangle(p1, p3, p2)):isCW())
  end)
  
  it('can also evaluate if triangle is defined counter-clockwise', function()
    local p1, p2, p3 = Point(), Point(1, 0), Point(1, 1)
    assert_true((Triangle(p1, p2, p3)):isCCW())
    assert_false((Triangle(p1, p3, p2)):isCCW())
  end)  

end)