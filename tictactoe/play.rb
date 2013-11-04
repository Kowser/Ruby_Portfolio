require './lib/board.rb'

@game
@computer_game = false
@computer_play = false

def draw_board
  puts "\e[H\e[2J"
  @game.board.each_with_index do |row,index|
    puts "\t#{row[0]} | #{row[1]} | #{row[2]}"
    puts "\t----------" if index < 2
  end
  puts "\n\n"
  puts "\ta b c"
  puts "\td e f"
  puts "\tg h i"
  puts "\n"
  (@computer_game && @computer_play) ? computer_turn : human_turn
end

def human_turn
  @computer_play = true
  puts "Player #{@game.current_player}'s turn. Please make a selection (a-i) to mark your square."
  player_turn(gets.chomp.downcase)
end

def computer_turn
  @computer_play = false
  player_turn(@game.computer_turn)
end

def player_turn(move)
  if @game.mark_square(move)

    if @game.over?
      puts "\e[H\e[2J"
      @game.board.each_with_index do |row,index|
        puts "\t#{row[0]} | #{row[1]} | #{row[2]}"
        puts "\t----------" if index < 2
      end
      puts "\n\n"
      puts @game.winner
      puts "\n\n\nPress any key to return to the main menu."
      gets.chomp
      menu
    elsif @game.cats_game?
      puts "\e[H\e[2J"
      @game.board.each_with_index do |row,index|
        puts "\t#{row[0]} | #{row[1]} | #{row[2]}"
        puts "\t----------" if index < 2
      end
      puts "\n\nMan you two are good. Nobody won. Cat's game."
      puts "\n\n\nPress any key to return to the main menu."
      gets.chomp
      menu
    else
      @game.change_player
      draw_board   
    end
      
  else puts "HAL: I'm sorry Player #{@game.current_player} I can't do that."
    human_turn
  end
end

def menu
  puts "\e[H\e[2J"
  puts "                Welcome to TIC TAC TOE, a Game of Cut Throats & Cats' Games\n\n"
  puts "                      Created by Michal K. & Hunter M. @ Epicodus 2013          "
  puts "                _______________________________________________________________\n\n"
  puts "                Press 'P' to play a 2-player game!"
  puts "                Press 'C' to play against the computer!"
  puts "                Press 'X' to exit."
  puts ""
  case gets.chomp.downcase
    when 'p'
      @game = Game.new
      draw_board
    when 'c'
      @game = Game.new
      @computer_game = true
      @computer_play = false
      draw_board
    when 'x'
      puts "\e[H\e[2J"
      exit
    else 'Invalid Selection.'
  end
end

menu
