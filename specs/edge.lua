require 'luacov'
local Point = (require "delaunay").Point
local Edge  = (require "delaunay").Edge

context("Edge", function()

  test('an Edge is created passing two Points', function()
    local e = Edge(Point(), Point(1,1))
    assert_equal(getmetatable(e), Edge)
  end)
  
  test('an edge has two members named p1 and p2, which are points', function()
    local p1, p2 = Point(), Point(1,1)
    local e = Edge(p1, p2)
    assert_equal(e.p1, p1)
    assert_equal(e.p2, p2)
  end)
  
  it('can test if edges are equal without considering their orientation', function()
    local p1, p2, p3 = Point(), Point(1,1), Point(1,2)
    local e1 = Edge(p1, p2)
    local e2 = Edge(p1, p2)
    local e3 = Edge(p2, p1)
    local e4 = Edge(p1, p3)
    assert_true(e1:same(e2))
    assert_true(e1:same(e3))
    assert_false(e1:same(e4))
  end)
  
  it('can also test if edges are strictly the same', function()
    local p1, p2, p3 = Point(), Point(1,1), Point(1,2)
    local e1 = Edge(p1, p2)
    local e2 = Edge(p1, p2)
    local e3 = Edge(p2, p1)
    local e4 = Edge(p1, p3)
    assert_true(e1 == e2)
    assert_false(e1 == e3)
    assert_false(e1 == e4)
  end)  
  
  it('can evaluate the edge mid-point coordinates', function()
    local e = Edge(Point(), Point(2,2))
    local x, y = e:getMidPoint()
    assert_equal(x, 1)
    assert_equal(y, 1)
  end)
  
  it('can evaluate the edge length', function()
    local e = Edge(Point(), Point(1,1))
    assert_equal(e:length(), math.sqrt(2))
  end)  
  

end)