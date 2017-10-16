require_relative 'circle'
require_relative 'point'
require 'test/unit'          #We need Ruby's unit testing library

class FactorialTest < Test::Unit::TestCase #This is a class. (It's ok if you don't know what those are yet

  def test_diameter
    circle = Circle.new(Point.new(0, 0), Point.new(0, 5))
    assert_equal 10, circle.diameter, "(0,0),(0,5) diameter should be 10"
  end  

  def test_circumference
    circle = Circle.new(Point.new(0, 0), Point.new(0, 5))
    assert_equal Math::PI * 10, circle.circumference, "(0,0),(0,5) circumference should be pi * 10"
  end

  def test_area
    circle = Circle.new(Point.new(0, 0), Point.new(0, 5))
    assert_equal Math::PI * 25, circle.area, "(0,0),(0,5) area should be pi * 25"
  end
end
