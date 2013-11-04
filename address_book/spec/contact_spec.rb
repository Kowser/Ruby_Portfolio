require 'rspec'
require 'contact'

describe Contact do
  it 'is initialized with a first and last name' do
    contact = Contact.new("Alex", "Gross")
    contact.full_name.should eq "Alex Gross"
  end

  it 'allows you to add a phone number to a contact' do
    contact = Contact.new("Alex", "Gross")
    contact.add_phone(5038675309)
    contact.phone.should eq 5038675309
  end

  it 'allows you to add an address to a contact' do
    contact = Contact.new("Alex", "Gross")
    contact.add_address("1029 B Street, Everett, WA 98802")
    contact.address.should eq "1029 B Street, Everett, WA 98802"
  end

  it 'allows you to add an email address to a contact' do
    contact = Contact.new("Alex", "Gross")
    contact.add_email("alex@nowhere.com")
    contact.email.should eq "alex@nowhere.com"
  end

  it 'allows you to define the type of contact' do
    contact = Contact.new("Alex", "Gross")
    contact.define_type(2)
    contact.type.should eq "Business"
  end
end
