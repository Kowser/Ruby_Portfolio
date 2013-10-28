require 'rspec'
require 'factorial.rb'

describe 'factorial' do 
  it 'multiplies a number by each number less that itself' do
    factorial(5).should eq 120
  end

  it 'will return 1 when the number entered is zero (0)' do
    factorial(0).should eq 1
  end
end
