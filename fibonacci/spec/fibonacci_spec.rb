require 'rspec'
require 'fibonacci.rb'

describe 'fibonacci' do
  it 'returns the fibonacci number at the specified index' do
    fibonacci(9).should eq 21
  end
end
