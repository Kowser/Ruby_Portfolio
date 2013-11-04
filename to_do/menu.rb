require './lib/list'
require './lib/task'

DB = PG.connect(:dbname => 'to_do')

def load
  @lists = List.all
  @tasks = Task.all
  menu
end

def menu
  puts "   \n\nWelcome to the To DO list!\n\n"
  puts "        Press 'B' to list your lists" if @lists != []
  puts "        Press 'A' to add a task" if @lists != []
  puts "        Press 'L' to list all of your tasks." if @tasks != []
  puts "        Press 'D' to delete a task" if @tasks != []
  puts "        Press 'O' to add a new list" 
  puts "        Press 'X' to exit"
  puts "        Press 'E' to edit task" if @task != []
  option = gets.chomp.downcase
  case option
  when 'b'
    @lists.each {|list| puts "\t" + list.name}
    menu
  when 'a'
    @lists.each {|list| puts "\t" + list.id + list.name}
    puts "add to which list number?"
    task_number = gets.chomp
    puts "type in the task description"
    task_name = gets.chomp
    puts "add a due date"
    task_due_date = gets.chomp
    task = Task.new(task_name, task_number)
    task.set_due_date(task_due_date)
    task.save
    load
  when 'l'
    puts "\n\n"
    @tasks.each {|task| p task.name}
    menu
  when 'd' 
    puts "Which task do you want to delete"
    puts "\n\n"
    @tasks.each { |task| puts "\t" + task.id + "\t" + task.name }
    puts "Enter the number of the task you would like to delete"
    delete_number = gets.chomp
    puts "your selection has been DELETED!"
    DB.exec("DELETE FROM tasks WHERE id = #{delete_number};")
    load
  when 'o'
    puts "Name your List"
    list_input = gets.chomp
    list = List.new(list_input)
    list.save
    load 

  when 'x'
    print "Good-bye Human!"
  else
    puts 'Invalid option! Try again!'
    menu
  end
end

load
