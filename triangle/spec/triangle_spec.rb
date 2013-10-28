require 'rspec'
require 'triangle.rb'

describe 'triangle' do
  it 'returns "invalid" if the sum of all sides are not greater than twice the largest side' do
    triangle(1, 2, 3).should eq 'invalid'
  end

  it 'returns "equilateral" if the 3 sides are equal to on another' do
    triangle(3, 3, 3).should eq 'equilateral'
  end

  it 'returns "isosceles" if only two sides are equal to each other' do
    triangle(2, 3, 3).should eq 'isosceles'
  end

  it 'returns "scalene" if no sides are equal' do
    triangle(3, 4, 5).should eq 'scalene'
  end
end
