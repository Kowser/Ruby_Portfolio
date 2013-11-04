require 'rspec'
require 'pig_latin.rb'

describe 'PIG LATIN' do
  describe 'pig_word' do
    it 'translates a word staring with a vowel' do
      pig_word('ensign').should eq 'ensignay'
    end

    it 'translates a word starting with a "qu"' do
      pig_word('quintessential').should eq 'intessentialquay'
    end

    it 'translates a word starting with one or more consonants' do
      pig_word('blank').should eq 'ankblay'
    end
  end

  describe 'pig_latin' do
    it 'translates an entire phrase into pig latin' do
      pig_latin('this is a sentence').should eq 'isthay isay aay entencesay'
    end
  end
end
