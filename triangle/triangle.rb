require './lib/triangle'

def menu
  puts 'Enter 1 side of triangle'
  side1 = gets.chomp.to_i
  puts 'Enter 2nd side of a triangle'
  side2 = gets.chomp.to_i
  puts 'Enter final 3rd side of a triangle'
  side3 = gets.chomp.to_i

  triangle = Triangle.new(side1,side2,side3)
  puts triangle.type
end

menu
