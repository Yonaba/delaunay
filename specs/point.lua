require 'luacov'
local Point = (require "delaunay").Point

context("Point", function()
      
  test('a new point has x and y members which defaults to 0,0', function()
    local p = Point()
    assert_not_nil(p.x)
    assert_not_nil(p.y)
    assert_equal(p.x, 0)
    assert_equal(p.y, 0)
  end)
  
  it('can create a point via __call(...)', function()
    local p = Point(0,0)
    assert_equal(getmetatable(p), Point)
    assert_equal(p.x, 0)
    assert_equal(p.y, 0)
  end)
  
  it('can create a point via new(...)', function()
    local p = Point:new(1,2)
    assert_equal(getmetatable(p), Point)
    assert_equal(p.x, 1)
    assert_equal(p.y, 2)
  end)
  
  it('can test if two given points are equal points', function()
    assert_equal(Point(), Point())
    assert_not_equal(Point(1,1), Point(1,2))
  end)
  
  it('can evaluate the distance between two points', function()
    assert_equal((Point()):dist(Point(2,0)), 2)
    assert_equal((Point()):dist(Point(1,1)), math.sqrt(2))
  end)  
  
  it('can evaluate the square distance', function()
    assert_equal((Point()):dist2(Point(2,0)), 4)
    assert_equal((Point()):dist2(Point(1,1)), 2)
  end)

  it('can test if a point lies in a circle', function()
    assert_true((Point()):isInCircle(0,0,1))
    assert_true((Point()):isInCircle(1,1,math.sqrt(2)))
    assert_false((Point()):isInCircle(1,1,1))
    assert_false((Point()):isInCircle(1,1,0.99))
  end)

end)