require 'pg'
require './lib/copy'
require './lib/item'
require './lib/patron'

DB = PG.connect(:dbname => 'biblioteka')

def main_menu
  puts "Welcome to the Epicodus library"
  puts "(N)ew users" 
  puts "(R)eturnings users"
  puts "e(X)it"
  input = gets.chomp.downcase
  case input
  when 'n'
    new_user_menu
  when 'r'
    verify_patron
  when 'x'
    "Goodbye"
  else
    puts 'Invalid entry, try again'
    main_menu
  end
end

def new_user_menu
  puts "\nSign up for a library card!"
  puts "What is your name?"
  input = gets.chomp
  # FIX ENTER = nothing but still makes a new user
  @patron = Patron.new({'name' => input})
  @patron.save('patrons')
  puts "Your library card number is: #{@patron.id}\n\n"
  main_menu
end

def returning_user_menu
  puts "" 
  puts "(L)ist all books"
  puts "(R)eturn a book"
  puts "(S)earch for a book"
  input = gets.chomp.downcase
  case input
  when 'l'
    list_all_books
  when 'r'
    return_book_menu
  when 's'
    results = search_library 
    want_to_check_it
  end
end

def search_library
  puts "Type in a search string"
  input = gets.chomp
  results = DB.exec("SELECT * FROM items WHERE title LIKE '%#{input}%';")
  if results.first == nil
    puts "No Results"
    returning_user_menu
  else
    results.each_with_index do |result, index|
      puts (index + 1).to_s + ". " + result['title']
    end
    results
  end
end

def check_out_menu(results)
  puts "Check out which book number?"
  book = gets.chomp.to_i - 1
  puts results[book]['id']
  copies = DB.exec("SELECT * FROM copies WHERE book_id = #{results[book]['id'].to_i};")
  copies.each do |copy|
    puts results[book]['title'] + ": Copy ID " + copy['id']
  end
  puts "Which copy ID do you want to check out?"
  copy_id = gets.chomp.to_i
  copy = Copy.new(DB.exec("SELECT * FROM copies WHERE id = #{copy_id};").first)
  copy.borrow(@card_number)
  puts "Borrowed"
  returning_user_menu
end

def return_book_menu
  mybooks = @patron.my_books
  if mybooks == []
    puts "No books currently checked out."
  else
    mybooks.each_with_index do |copy, index|
      puts (index + 1).to_s + ". " + DB.exec("SELECT * FROM items WHERE id = #{copy.book_id};").first['title']
    end
    puts "Enter number of book to return, or e(X)it"
    choice = gets.chomp
    if choice.downcase = 'x'
    else
    choice = choice.to_i - 1
      if choice >= 0 && choice < mybooks.length
        mybooks[choice].return if 
        puts "Returned"
      else
        puts "Invalid input"
        return_book_menu
      end
    end
  end
  returning_user_menu
end

def verify_patron
  puts "Enter your library card number\n\n"
  @card_number = gets.chomp.to_i
  if DB.exec("SELECT * FROM patrons WHERE id = #{@card_number};").first != nil
    @patron = Patron.new(DB.exec("SELECT * FROM patrons WHERE id = #{@card_number};").first)
    returning_user_menu
  else
    puts "No members match that card number"
    main_menu
  end
end

def list_all_books
  results = DB.exec("SELECT * FROM items;")
  p results
  results.each_with_index do |result, index|
    puts (index + 1).to_s + ". " + result['title'] + " by " + result['author']
    item_num += 1
  end
  want_to_check_it
  returning_user_menu
end

def want_to_check_it
  puts "Would you like to check out one of these? Y/n"
  input = gets.chomp.downcase
  case input
  when 'y'
    check_out_menu(results)
  when 'n'
    returning_user_menu
  else
    puts 'Invalid entry, try again'
    returning_user_menu
  end
  else
    puts 'Invalid Option'
    returning_user_menu
  end
end

# def init
#   populate_library
# end
# def populate_library
  # book1 = Item.new({'title' => 'The Pokey Little Puppy', 'author' => 'Some Gal'})
  # book1.save
  # copy = Copy.new({'book_id' => book1.id})
  # copy.save
  # book2 = Item.new({'title' => 'Where the Sidewalk Ends', 'author' => 'Shel Silverstein'})
  # book2.save
  # copy = Copy.new({'book_id' => book2.id})
  # copy.save
  # book3 = Item.new({'title' => 'The Good Life', 'author' => 'Scott Nearing'})
  # book3.save
  # copy = Copy.new({'book_id' => book3.id})
  # copy.save
  # book4 = Item.new({'title' => 'Where the Red Fern Grows', 'author' => 'Some Guy'})
  # book4.save
  # copy = Copy.new({'book_id' => book4.id})
  # copy.save
  # book5 = Item.new({'title' => 'Where the Sidewalk Ends', 'author' => 'Shel Silverstein'})
  # book5.save
  # 3.times do
  #   copy = Copy.new({'book_id' => book5.id})
  #   copy.save
  # end
  # book6 = Item.new({'title' => 'Cryptonomicon', 'author' => 'Neal Stephenson'})
  # book6.save
  # 4.times do
  #   copy = Copy.new({'book_id' => book6.id})
  #   copy.save
  # end
  # book7 = Item.new({'title' => 'Baby Doll', 'author' => 'Michael Oppenheim'})
  # book7.save
  # copy = Copy.new({'book_id' => book7.id})
  # copy.save
  # book8 = Item.new({'title' => 'Monkeyluv', 'author' => 'Robert Sapolski'})
  # book8.save
  # copy = Copy.new({'book_id' => book8.id})
  # copy.save
# end

# def empty_library
#   DB.exec("DELETE FROM items *;")
#   DB.exec("DELETE FROM copies *;")
# end

main_menu
