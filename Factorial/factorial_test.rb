require_relative 'factorial' #We need to access our code to test
require 'test/unit'          #We need Ruby's unit testing library

class FactorialTest < Test::Unit::TestCase #This is a class. (It's ok if you don't know what those are yet

  #Test methods MUST start with test_
  def test_normal
    assert_equal 24, factorial(4),"4! should be 24"
  end
  
  def test_another_normal
    assert_equal 120, factorial(5),"5! should be 120"
  end

  def test_zero
    assert_equal 1, factorial(0), "0! should be 1"
  end

  def test_negative
    ex = assert_raise(ArgumentError) {factorial(-1)}
    assert_equal "Negative", ex.message, "exception message should be Negative"
  end

  def test_string
    ex = assert_raise(ArgumentError) { factorial("string") }
    assert_equal "NonInteger", ex.message, "exception message should be NonInteger"
  end
  
end
