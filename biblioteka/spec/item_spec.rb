require 'spec_helper'

new_item = {'title' => 'The Pokey Little Puppy', 'creator' => 'Some Gal', 'type' => 'book'}

describe Item do
  it 'is initialized with a title and author' do
    item = Item.new(new_item)
    item.should be_an_instance_of Item
  end

  it 'lets you return the title' do
    item = Item.new(new_item)
    item.title.should eq 'The Pokey Little Puppy'
  end

  it 'lets you return the creator' do
    item = Item.new(new_item)
    item.creator.should eq 'Some Gal'
  end

  it 'lets you return the media type' do
    item = Item.new(new_item)
    item.type.should eq 'book'
  end

  it 'is the same item if all properties are equal' do
    item1 = Item.new(new_item)
    item2 = Item.new(new_item)
    item1.should eq item2
  end

  it 'lets you save a item to the database' do
    item = Item.new(new_item)
    item.save('items')
    Item.all('items').should eq [item]
  end

  it 'sets its ID when you save it' do
    item = Item.new(new_item)
    item.save('items')
    item.id.should be_an_instance_of Fixnum
  end
end