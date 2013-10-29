class Game
  attr_reader :board, :current_player
  
  def initialize
    @board = [["_", "_", "_"],
              ["_", "_", "_"],
              ["_", "_", "_"]]
    @current_player = "X"
  end

  def change_player
    @current_player == "X"? @current_player = "O" : @current_player = "X"
    puts "\e[H\e[2J"
  end

  def mark_square(position)
    case position.downcase
      when "a"
        @board[0][0] == "_" ? @board[0][0] = @current_player : false 
      when "b"
        @board[0][1] == "_" ? @board[0][1] = @current_player : false
      when "c"
        @board[0][2] == "_" ? @board[0][2] = @current_player : false
      when "d"
        @board[1][0] == "_" ? @board[1][0] = @current_player : false
      when "e"
        @board[1][1] == "_" ? @board[1][1] = @current_player : false
      when "f"
        @board[1][2] == "_" ? @board[1][2] = @current_player : false
      when "g"
        @board[2][0] == "_" ? @board[2][0] = @current_player : false
      when "h"
        @board[2][1] == "_" ? @board[2][1] = @current_player : false
      when "i"
        @board[2][2] == "_" ? @board[2][2] = @current_player : false
      else false
    end
  end

  def over
    over = false
    (0..2).each do |i|
      if @board[i][0] + @board[i][1] + @board[i][2] == @current_player * 3
        over = true
      elsif @board[0][i] + @board[1][i] + @board[2][i] == @current_player * 3
        over = true
      elsif @board[0][0] + @board[1][1] + @board[2][2] == @current_player * 3
        over = true
      elsif @board[0][2] + @board[1][1] + @board[2][0] == @current_player * 3
        over = true
      end
    end
    over
  end

  def not_cats_game
    @board.flatten.include?("_")
  end

  def winner
    "Player #{@current_player} is the winner!"
  end

  def computer_turn
    alphabet = %w[a b c d e f g h i]
    possible_moves = []
    @board.flatten.each_with_index do |square, index|
      possible_moves << alphabet[index] if square == "_"
    end
    possible_moves[rand(0...possible_moves.length).floor]
  end

end