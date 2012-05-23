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

  args = [a,b,c]
  if args.count(0) == 3
    raise TriangleError.new "Cannot be all zeroes"
  end

  results = [a == b, a == c, b == c]

  if results.count(true) == 3
    :equilateral
  else 
    if results.count(true) == 1
      :isosceles
    else
      :scalene
    end
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
