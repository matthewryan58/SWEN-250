require_relative 'rectangle'
require_relative 'point'
require 'test/unit'          #We need Ruby's unit testing library

class FactorialTest < Test::Unit::TestCase #This is a class. (It's ok if you don't know what those are yet

  def test_width
    rect = Rectangle.new(Point.new(0, 0), Point.new(5, 5))
    assert_equal 5, rect.width, "(0,0),(5,5) width should be 5"
  end  

  def test_height
    rect = Rectangle.new(Point.new(0, 0), Point.new(5, 5))
    assert_equal 5, rect.height, "(0,0),(5,5) height should be 5"
  end

  def test_perimeter
    rect = Rectangle.new(Point.new(0, 0), Point.new(5, 5))
    assert_equal 20, rect.perimeter, "(0,0),(5,5) perimeter should be 20"
  end

  def test_area
    rect = Rectangle.new(Point.new(0, 0), Point.new(5, 5))
    assert_equal 25, rect.area, "(0,0),(5,5) area should be 25"
  end
end
