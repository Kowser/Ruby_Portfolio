require 'spec_helper'

new_copy = {'book_id' => 2}

describe Copy do
  it 'is initialized with a book_id' do
    copy = Copy.new(new_copy)
    copy.book_id.should eq 2
  end

  it 'is initialized with a checked_out status of false' do
    copy = Copy.new(new_copy)
    copy.checked_out.should eq false
  end

  it 'lets you save a copy to the database' do
    copy = Copy.new(new_copy)
    copy.save('copies')
    Copy.all('copies').should eq [copy]
  end

  it 'is the same copy if all properties are equal' do
    copy1 = Copy.new(new_copy)
    copy2 = Copy.new(new_copy)
    copy1.should eq copy2
  end

  it 'is not the same as instances of other classes' do
    copy = Copy.new(new_copy)
    copy.should_not eq 5
  end

  it 'changes the checked_out status to true when borrowed' do
    copy = Copy.new(new_copy)
    copy.save('copies')
    copy.borrow(4)
    copy.checked_out.should eq true
    Copy.all('copies').should eq [copy]
    copy.patron_id.should eq 4
  end

  it 'changes the checked_out status to false when returned' do
    copy = Copy.new(new_copy)
    copy.save('copies')
    copy.borrow(4)
    copy.return
    copy.checked_out.should eq false
    Copy.all('copies').should eq [copy]
  end
end