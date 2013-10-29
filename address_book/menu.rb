require './lib/contact'
require './lib/addy'

@addressbook = AddressBook.new
contact1 = Contact.new("Sample", "Nobody")
contact1.add_phone(4356654453)
contact1.add_email("this@this.com")
contact1.add_address("23242 Mountain Top Dr.")
contact1.define_type(1)

contact2 = Contact.new("Sample", "Somebody")
contact3 = Contact.new("Who", "IsOnfirst")
contact4 = Contact.new("Where", "Thecheeseat")
@addressbook.add_contact(contact1)
@addressbook.add_contact(contact2)
@addressbook.add_contact(contact3)
@addressbook.add_contact(contact4)


def menu
  puts "Welcome to Address Book! Make a selection"
  puts ""
  puts "Press 'A' to add a new contact"
  puts "Press 'L' to list your contacts." if @addressbook.list != []
  puts "Press 'V' to view a contact." if @addressbook.list != []
  puts "Press 'D' to delete a contact" if @addressbook.list != []
  puts "Press 'E' to edit a contact" if @addressbook.list != []
  puts "Press 'S' to search for a contact" if @addressbook.list != []
  puts "Press 'X' to exit"

  choice = gets.chomp.downcase

  case choice
  when 'a'
    puts "Please type the first name"
    first_name = gets.chomp
    puts "Please type the last name"
    last_name = gets.chomp
    contact = Contact.new(first_name, last_name)
    @addressbook.add_contact(contact)
    menu
  when 'l'
    puts "Here is your list of contacts"
    @addressbook.list.each {|contact| puts contact.full_name}
    menu
  when 'v'
    puts "Which contact do you want to view?"
    puts ""
    @addressbook.list.each_with_index do |contact, index|
      puts "  " + (index + 1).to_s + ". " + contact.full_name
    end
    contact = @addressbook.list[gets.chomp.to_i - 1]
    puts "  #{contact.full_name}"
    puts "    #{contact.address}"
    puts "    #{contact.phone}"
    puts "    #{contact.email}"
    puts "    #{contact.type}"
    menu
  when 'd'
    puts "Which contact do you want to delete?"
    puts ""
    @addressbook.list.each_with_index do |contact, index|
      puts (index + 1).to_s + ". " + contact.full_name
    end
    @addressbook.delete_contact_by_index(gets.chomp.to_i)
    menu
  when 'e'
    puts "Which contact do you want to edit?"
    @addressbook.list.each_with_index do |contact, index|
      puts (index + 1).to_s + ". " + contact.full_name
    end
    @editing_contact = gets.chomp.to_i - 1
    edit_menu
  when 's' 
    puts "Search the contact list"
    search = gets.chomp.downcase
    puts ""
    puts "Here are your results"
    @addressbook.search_list(search).each {|result| puts result}
    menu
  when 'x'
    puts "Good-bye Human!"
  else
    puts 'Invalid entry illiterate human! Try again!'
    menu
  end
end

def edit_menu
  puts "What information would you like to edit?"
  puts ""
  puts "1. First Name"
  puts "2. Last Name"
  puts "3. Phone"
  puts "4. Physical Address"
  puts "5. Email Address"
  puts "6. Contact Type"
  puts "7. Return to Main Menu"

  info = gets.chomp.to_i

  case info
  when 1
    puts "Please type a first name"
    @addressbook.list[@editing_contact].edit_first_name(gets.chomp)
    edit_menu
  when 2
    puts "Please type a last name"
    @addressbook.list[@editing_contact].edit_last_name(gets.chomp)
    edit_menu
  when 3
    puts "Please type a new phone number"
    @addressbook.list[@editing_contact].add_phone(gets.chomp)
    edit_menu
  when 4
    puts "Please type a new address"
    @addressbook.list[@editing_contact].add_address(gets.chomp)
    edit_menu
  when 5
    puts "Please type a new email address"
    @addressbook.list[@editing_contact].add_email(gets.chomp)
    edit_menu
  when 6
    puts "Please select a new type"
    puts "1 - Family"
    puts "2 - Business"
    @addressbook.list[@editing_contact].define_type(gets.chomp.to_i)
    edit_menu
  when 7
    menu
  end 
end

menu








