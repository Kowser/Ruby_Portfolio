require 'rspec'
require 'addy'
require 'contact'

describe AddressBook do
  it 'initializes an Address Book array' do
    new_addressbook = AddressBook.new
    new_addressbook.list.should eq []
  end

  it 'allows you to add a contact to the list' do
    new_addressbook = AddressBook.new
    contact = Contact.new("Alex", "Gross")
    new_addressbook.add_contact(contact)
    new_addressbook.list.length.should eq 1
  end

  it 'allows you to add multiple contacts' do
    new_addressbook = AddressBook.new
    contact = Contact.new("Alex", "Gross")
    new_addressbook.add_contact(contact)
    contact2 = Contact.new("Moneer", "Bandy")
    new_addressbook.add_contact(contact2)
    new_addressbook.list.length.should eq 2
  end

  it 'allows you to delete a contact' do
    new_addressbook = AddressBook.new
    contact = Contact.new("Alex", "Gross")
    new_addressbook.add_contact(contact)
    contact2 = Contact.new("Moneer", "Bandy")
    new_addressbook.add_contact(contact2)
    new_addressbook.delete_contact_by_index(1)
    new_addressbook.list.length.should eq 1
  end

  it 'deletes a contact from address book by name' do
    new_addressbook = AddressBook.new
    contact = Contact.new("Alex", "Gross")
    new_addressbook.add_contact(contact)
    contact2 = Contact.new("Moneer", "Bandy")
    new_addressbook.add_contact(contact2)
    new_addressbook.delete_contact_by_name("Alex Gross")
    new_addressbook.list.length.should eq 1
  end

  it 'searches the list for matches to the search term' do
    addressbook = AddressBook.new
    contact1 = Contact.new("Guy", "DoNoGood")
    contact2 = Contact.new("Joe", "Dumb")
    contact3 = Contact.new("Ken", "UnSmart")
    contact4 = Contact.new("Luke", "Biff")
    addressbook.add_contact(contact1)
    addressbook.add_contact(contact2)
    addressbook.add_contact(contact3)
    addressbook.add_contact(contact4)
    addressbook.search_list("smart").should eq ["Ken UnSmart"]
  end
end
