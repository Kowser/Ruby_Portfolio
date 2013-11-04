require 'active_record'
require 'pry'

require './lib/survey'
require './lib/question'
require './lib/answer'
require './lib/response'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  choice = nil
  until choice == 'x'
    puts "\e[H\e[2J"
    puts "Welcome to the Surveyor mission!"
    puts
    puts "\t[S]urveys Menu"
    puts "\t[Q]uestions Menu" if Survey.all.length > 0
    puts "\t[A]nswers Menu" if Question.all.length > 0
    puts "\t-----------------"
    puts "\t[T]ake Survey"
    puts "\t[V]iew Responses"
    puts "\t-----------------"
    puts "\te[X]it"
    puts
    choice = gets.chomp.downcase
    case choice
    when 's'
      survey_menu
    when 'q'
      question_menu
    when 'a'
      answer_menu
    when 't'
      survey_list
      take_survey(get_survey)
    when 'v'
      survey_list
      list_response(get_survey)
    when 'x'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

# -----------SURVEY------------
def survey_menu
  choice = nil
  until choice == 'm'
    puts "[A]dd a survey, [L]ist surveys, or [M]ain Menu."
    choice = gets.chomp.downcase
    case choice
    when 'a'
      survey_add
    when 'l'
      survey_list
    when 'm'
      # returns to main menu
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def survey_add
  puts "Enter survey name"
  survey_name = gets.chomp.capitalize
  puts "Enter survey description"
  survey_description = gets.chomp
  Survey.create(name: survey_name, :description => survey_description)
  "'#{survey_name}' has been added to your list."
end

def survey_list
  puts "Here are all your survey:"
  Survey.all.each_with_index {|survey, index| puts "#{index + 1}. #{survey.name}" }
end


# -----------QUESTION------------
def question_menu
  choice = nil
  until choice == 'x'
    puts "[A]dd a Question to a Survey, [L]ist questions, [d]elete or e[X]it."
    choice = gets.chomp.downcase
    case choice
    when 'a'
      survey_list
      question_add(get_survey)
    when 'l'
      survey_list
      question_list(get_survey)
    when 'd'
      survey_list
      question_list(get_survey)
      question_delete(get_question)
    when 'x'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def question_add(survey)
  puts "Enter question text"
  question_text = gets.chomp.capitalize
  survey.questions << Question.create(text: question_text)
  puts "'#{question_text}' has been added to survey #{survey.name}."
end

def question_delete(question)
  question.destroy
end

def get_survey
  puts 'Select survey number'
  Survey.all[gets.chomp.to_i - 1]
end

def question_list(survey)
  puts "Questions in this surveys:"
  survey.questions.each_with_index do |question,index|
    puts "\t#{index + 1}. #{question.text}"
  end
end

# -----------ANSWER------------
def answer_menu
  choice = nil
  until choice == 'x'
    puts "[A]dd an Answer to a Question, [L]ist answers, or e[X]it."
    choice = gets.chomp.downcase
    case choice
    when 'a'
      survey_list
      question_list(get_survey)
      answer_add(get_question)
    when 'l'
      survey_list
      question_list(get_survey)
      answer_list(get_question)
    when 'x'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def get_question
  puts 'Select question number'
  Question.all[gets.chomp.to_i - 1]
end

def answer_add(question)
  choice = nil
  until choice == 'x'
    puts "Enter answer text or e[X]it"
    choice = gets.chomp
    case choice
    when 'X'
      # returns to answer menu
    when 'x'
      # returns to answer menu
    else
      question.answers << Answer.create(text: choice.capitalize)
      puts "#{choice.capitalize} has been added to question #{question.text}."
    end
  end
end

def answer_list(question)
  question.answers.each_with_index do |answer, index|
    puts "#{index +1}. #{answer.text}"
  end
end

# -----------SURVEY TAKING------------
def take_survey(survey)
  survey.questions.each do |question|
    puts "#{question.text} "
    question.answers.each_with_index do |answer, index| 
      puts "#{index + 1}. #{answer.text}"
    end
    puts "Enter answer number"
    Response.create(answer_id: question.answers[gets.chomp.to_i - 1].id)
  end
end

def list_response(survey)
  survey.questions.each_with_index do |question,index|
    puts " #{index + 1}. #{question.text} TOTAL: #{question.responses.count}"
    question.answers.each do |answer|
      puts "\t #{answer.text} #{answer.responses.count} (#{(answer.responses.count.to_f / question.responses.count.to_f) * 100}%)"
    end
    puts
  end
  puts "Press 'Enter' key to continue"
  gets.chomp
end

welcome
