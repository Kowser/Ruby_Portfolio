class Triangle
  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3]
  end

  attr_reader :sides

  def type
    if @sides.max * 2 >= @sides[0] + @sides[1] + @sides[2]
      'Triangle is invalid!'
    elsif @sides[0] == @sides[1] && @sides[1] == @sides[2]
      'Triangle is equilateral!'
    elsif @sides[0] == @sides[1] || @sides[1] == @sides[2] || @sides[0] == @sides[2]
      'Triangle is isosceles!'
    else
      'I am a scalene triangle (none of my sides match any other)!'
    end
  end
end
