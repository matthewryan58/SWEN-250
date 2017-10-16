require_relative 'line'
require_relative 'point'
require 'test/unit'          #We need Ruby's unit testing library

class FactorialTest < Test::Unit::TestCase #This is a class. (It's ok if you don't know what those are yet

  def test_lr # test line left, right, horizontal
    line = Line.new(Point.new(0, 0), Point.new(0, 5))
    assert_equal 5, line.length,"(0,0), (0,5) length should be 5"
  end

  def test_rl # test line right, left, horizontal
    line = Line.new(Point.new(0, 5), Point.new(0, 0))
    assert_equal 5, line.length, "(0,5), (0,0) length should be 5"
  end

  def test_du # test line down, up, vertical
    line = Line.new(Point.new(0, 0), Point.new(5, 0))
    assert_equal 5, line.length, "(0,0), (5,0) length should be 5"
  end

  def test_ud # test line up, down, vertical
    line = Line.new(Point.new(5, 0), Point.new(0, 0))
    assert_equal 5, line.length, "(5,0), (0,0) length should be 5"
  end

  def test_diag # test diag
    line = Line.new(Point.new(0, 0), Point.new(5, 5))
    assert_equal Math.sqrt(50), line.length, "(0, 0), (5, 5) length should be sqrt(50)"
  end
end
