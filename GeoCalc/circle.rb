# Circles are defined by the center point and a point
# on the circle itself, though internally we store
# the center point and radius.
# Circles are immutable - once constructed the points
# cannot be changed.

require './point'

class Circle
  # Methods below are private.
  private

  # Initialize the Circle from its center point and
  # a point on the circle.
  # The instance variables are @center and @radius
  # (The radius is the distance between the two points).
  def initialize(center = Point.new, on_circle = Point.new)
	@center = center
	@radius = center.distance(on_circle).abs
  end

  # Methods below are public
  public

  # Allow read access to the center point and radius
  attr_reader :center, :radius

  # Circle diameter
  # This *MUST* be written using the radius method.
  def diameter
	@radius * 2
  end

  # Circle circumerence
  # This *MUST* be written using the diameter method.
  def circumference
	Math::PI * diameter
  end

  # Circle area
  # This *MUST* be written using the radius method.
  def area
	Math::PI * (@radius ** 2)
  end

  def to_s
    "Circle center #{center} and radius #{radius}"
  end
end
