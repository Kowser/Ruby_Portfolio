require 'active_record'
require 'Date'

require '../lib/event'
require '../lib/task'
require '../lib/note'

ActiveRecord::Base.establish_connection(YAML::load(File.open('../db/config.yml'))["development"])

def welcome
  puts "\e[H\e[2J"
  puts "Welcome to Calendar Girl"
  main_menu
end

def main_menu
  user_choice = nil 
  until user_choice == 'x'
    puts "\n   Enter 'ce' to create a new event"
    puts "\t 've' to view all upcoming events"
    puts "\t 's' to see events on a particular day, week, or month"
    puts "\t 'ct' to create a new task "
    puts "\t 'vt' to view all tasks "
    puts "\t 'cn' to create a note for a task or event"
    puts "\t 'x' to exit"
    user_choice = gets.chomp.downcase
    case user_choice
    when 'ce'
      create_event
    when 'ct'
      create_task
    when 've'
      view_events
    when 'vt'
      view_tasks
    when 's'
      view_events_in_timespan
    when 'cn'
      create_note
    when 'x'
      puts "Good-bye!"
    else
      puts "\nThat is not a valid option\n"
    end
  end
end

def create_task
  puts "\e[H\e[2J"
  puts 'Enter task description'
  description = gets.chomp
  Task.create(description: description)
  puts "Task '#{description}' added to list."
end

def create_event
  puts "\tCreate Event\n\n"
  puts 'Enter event name'
  name = gets.chomp.capitalize
  puts 'Enter description'
  description = gets.chomp
  puts 'Enter location'
  location = gets.chomp
  puts 'Start date (yyyy/mm/dd)'
  start_date = gets.chomp
  puts 'Start time (HH:MM AM/PM)'
  start_time = gets.chomp
  start_datetime = DateTime.parse("#{start_date}T#{start_time}")
  puts 'End date (yyyy/mm/dd)'
  end_date = gets.chomp
  puts 'End time (HH:MM AM/PM)'
  end_time = gets.chomp
  end_datetime = DateTime.parse("#{end_date}T#{end_time}")
  Event.create(name: name, description: description, start_time: start_datetime, end_time: end_datetime)
  puts 'Event created'
end

def view_events
  puts "\e[H\e[2J"
  puts "All Upcoming Events\n\n"
  Event.upcoming.each do |event|
    show_event(event)
  end
end

def view_events_in_timespan
  puts 'Choose time frame (D)ay, (W)eek, (M)onth'
  spans = { 'd' => :day, 'w' => :week, 'm' => :month }
  timespan = spans[gets.chomp.downcase]
  puts 'Choose starting day (yyyy/mm/dd)'
  day = Date.parse(gets.chomp)
  user_choice = nil
  until user_choice == 'x'
    show_events(timespan, day)
    puts "Enter 'n' to see next, or 'p' to see previous, 'x' to return to the main menu"
    user_choice = gets.chomp.downcase
    case user_choice
    when 'n'
      new_dates_next = { day: day + 1, week: day + 7, month:  day >> 1 }
      day = new_dates_next[timespan]
    when 'p'
      new_dates_previous = { day: day - 1, week: day - 7, month:  day << 1 }
      day = new_dates_previous[timespan]
    when 'x'
      puts "Returning to previous menu"
    end
  end
end

def show_events(timespan, day)
  puts "\e[H\e[2J"
  Event.search(timespan, day).each do |event|
    show_event(event)
  end
end

def show_event(event)
  puts "Event Name: #{event.name}"
  puts "Description: #{event.description}"
  puts "#{(event.start_time).strftime("%m/%d/%Y at %H:%M %p")} to #{event.end_time.strftime("%m/%d/%Y at %H:%M %p")}."
  if event.notes.length > 0
    puts "Notes:"
    event.notes.each { |note| puts "\t#{note.content}" }
  end
  puts "\n\n"
end

def create_note
  puts "Do you want to add a note to a [t]ask or an [e]vent?"
  user_choice = gets.chomp.downcase
  if user_choice == 't'
    Task.all.each_with_index do |task, index|
      puts "#{index + 1}. #{task.description}"
    end
    puts "\nEnter the number of the task you would like to add a note for."
    task = Task.all[gets.to_i - 1]
    puts "\n\n#{task.description} selected"
    puts "\nWhat would you like the note to say?"
    content = gets.chomp
    note = Note.create(:content => content)
    task.notes << note
    if note.valid?
      puts "Note added to the task."
    else
      puts "Error invalid note."
      note.errors.full_messages.each { |message| puts message }
    end
  elsif user_choice == 'e'
    Event.all.each_with_index do |event, index|
      puts "#{index + 1}. #{event.name}"
    end
    puts "Enter the event number to add a note to."
    event = Event.all[gets.to_i - 1]
    puts "\n\n#{event.name} selected"
    puts "\nWhat would you like the note to say?"
    content = gets.chomp
    event.notes << Note.create(content: content)
    puts "Note added to the event"
  else
    "Invalide selection"
    create_note
  end
end

def view_tasks
  puts "\e[H\e[2J" 
  puts "Tasks:"
  Task.all.each do |task| 
    puts "\t#{task.description}"
    if task.notes.length > 0
      puts "\tNotes:"
      task.notes.each { |note| puts "\t\t#{note.content}" }
    end
    puts "\n\n"
  end
end

welcome