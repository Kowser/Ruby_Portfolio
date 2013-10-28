require 'rspec'
require 'title_case.rb'

describe 'title_case' do
  it 'capitalizes the first letter' do
    title_case('something').should eq 'Something'
  end

  it 'capitalizes the first letter of every word in a string' do
    title_case('i am a smart person').should eq 'I Am a Smart Person'
  end

  it 'capitalizes the first word of every string' do
    title_case('a man').should eq 'A Man'
  end
end

describe 'is_exception' do
  it 'does not capitalize a word found in the exception list' do
    is_exception('and').should eq true
  end
end
