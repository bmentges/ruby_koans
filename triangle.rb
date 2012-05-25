# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  triangle = Triangle.new(a, b, c)
  triangle.type
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

class Triangle
  def initialize(a, b, c)
    @sides = [a, b, c].sort
    guard_against_invalid_lengths
  end

  def type
    case @sides.uniq.size
    when 1 then :equilateral
    when 2 then :isosceles
    else :scalene
    end
  end

  private
    def guard_against_invalid_lengths
      if @sides.any? { |x| x <= 0 }
        raise TriangleError, "Sides must be greater than 0"
      end

      if @sides[0] + @sides[1] <= @sides[2]
        raise TriangleError, "Not valid triangle lengths"
      end
    end
end
