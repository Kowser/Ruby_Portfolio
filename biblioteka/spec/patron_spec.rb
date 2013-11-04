require 'spec_helper'

new_patron = {'name' => 'Abby'}

describe Patron do
  it 'is initialized with a name' do
    patron = Patron.new(new_patron)
    patron.should be_an_instance_of Patron
  end

  it 'lets you return the name' do
    patron = Patron.new(new_patron)
    patron.name.should eq 'Abby'
  end

  it 'is the same patron if all properties are equal' do
    patron1 = Patron.new(new_patron)
    patron2 = Patron.new(new_patron)
    patron1.should eq patron2
  end

  it 'lets you save a patron to the database' do
    patron = Patron.new(new_patron)
    patron.save('patrons')
    Patron.all('patrons').should eq [patron]
  end

  it 'sets its ID when you save it' do
    patron = Patron.new(new_patron)
    patron.save('patrons')
    patron.id.should be_an_instance_of Fixnum
  end

  it 'provides a list of the patron\'s checked out books' do
    patron = Patron.new(new_patron)
    patron.save('patrons')
    copy1 = Copy.new({'book_id' => 1})
    copy1.save('copies')
    copy1.borrow(patron.id)
    copy2 = Copy.new({'book_id' => 2})
    copy2.save('copies')
    copy2.borrow(patron.id)
    patron.my_books.should eq [copy1, copy2]
  end
end