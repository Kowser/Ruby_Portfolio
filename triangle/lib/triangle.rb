def triangle(a, b, c)
  if a + b + c <= [a,b,c].max * 2
    'invalid'
  elsif a == b && b == c
    'equilateral'
  elsif a == b || b == c || a == c
    'isosceles'
  else
    'scalene'
  end
end
