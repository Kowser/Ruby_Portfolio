require 'rspec'
require 'number_to_words.rb'

describe 'less_than_twenty' do
  it 'converts any number less than 20 into a written word' do
    less_than_twenty(19)
    $answer.reverse.join(" ").should eq 'nineteen'
    $answer = []
  end
end

describe 'less_than_hundred' do
  it 'converts any number divisible by ten less than 100 into words' do
    less_than_hundred(90)
    $answer.reverse.join(" ").should eq 'ninety'
    $answer = []
  end

  it 'converts any number less than 100 into written words' do
    less_than_hundred(99)
    $answer.reverse.join(" ").should eq 'ninety nine'
    $answer = []
  end
end

describe 'less_than_thousand' do
  it 'converts any even hundred less than one thousand into written words' do
    less_than_thousand(900)
    $answer.reverse.join(" ").should eq 'nine hundred'
    $answer = []
  end

  it 'converts any number less than one thousand to written words' do
    less_than_thousand(999)
    $answer.reverse.join(" ").should eq 'nine hundred ninety nine'
    $answer = []
  end
end

describe 'numbers_to_words' do
  it 'converts an even thousand number into words' do
    numbers_to_words(9000)
    $answer.reverse.join(" ").should eq 'nine thousand'
    $answer = []
    $i = 1
  end

  it 'converts a number less than ten thousand to a written word' do
    numbers_to_words(9999)
    $answer.reverse.join(" ").should eq 'nine thousand nine hundred ninety nine'
    $answer = []
    $i = 1
  end

  it 'converts ANY number less than a nonillion into words' do
    numbers_to_words(9999999)
    $answer.reverse.join(" ").should eq 'nine million nine hundred ninety nine thousand nine hundred ninety nine'
    $answer = []
    $i = 1
  end
end
