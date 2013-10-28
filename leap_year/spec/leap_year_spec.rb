require 'rspec'
require 'leap_year'

describe 'leap_year' do
  it 'returns true if the year is divisible by 400' do
    leap_year(1600).should eq true
  end

  it 'returns false if the year is  divisible by 100' do
    leap_year(1700).should eq false
  end

  it 'returns true if the year is divisible by 4' do
    leap_year(1992).should eq true
  end

  it 'returns false if year fails all other tests' do
    leap_year(2013).should eq false
  end
end

describe 'is_positive_integer' do
  it 'returns false if year is positive' do
    is_positive_integer(-1986).should eq false
  end

  it 'returns false if the year is not an integer' do
    is_positive_integer(987.654321).should eq false
  end
end
