require 'rspec'
require 'triangle'

describe Triangle do
  it 'is initialized with 3 arguments, one for each side of a triangle' do
    triangle = Triangle.new(3,2,2)
    triangle.should be_an_instance_of Triangle
  end

  it "returns the 3 sides you entered" do
    triangle = Triangle.new(1,2,3)
    triangle.sides.should eq [1,2,3]
  end
  
  it 'returns an invalid message when the triangle is invalid' do
    triangle = Triangle.new(1,2,3)
    triangle.type.should eq 'Triangle is invalid!'
  end

  it 'returns an equilateral triangle when 3 sides are equal' do
    triangle = Triangle.new(3,3,3)
    triangle.type.should eq 'Triangle is equilateral!'
  end

  it "returns an isosceles if only 2 sides are equal" do
    triangle = Triangle.new(2,2,3)
    triangle.type.should eq'Triangle is isosceles!'
  end

  it "returns scalene if none of the other cases match" do
    triangle = Triangle.new(4,2,3)
    triangle.type.should eq 'I am a scalene triangle (none of my sides match any other)!'
  end
end
