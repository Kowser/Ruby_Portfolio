require 'rspec'
require 'board'

describe Game do
  it "is initialized with an empty board" do
    game = Game.new
    game.board.should eq [["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"]]
  end

  it "is initialized with a current player, X" do
    game = Game.new
    game.current_player.should eq "X"
  end

  it "changes the current player" do
    game = Game.new
    game.change_player
    game.current_player.should eq "O"
  end

  it "allows a player to make a mark (X,O) on the board" do
    game = Game.new
    game.mark_square("c")
    game.board.should eq [["_", "_", "X"], ["_", "_", "_"], ["_", "_", "_"]]
  end

  it "allows the next player to make a mark (X,O) on the board" do
    game = Game.new
    game.mark_square("c")
    game.change_player
    game.mark_square("a")
    game.board.should eq [["O", "_", "X"], ["_", "_", "_"], ["_", "_", "_"]]
  end

  it "checks to make sure the spot isn't occupied" do
    game = Game.new
    game.mark_square("c")
    game.change_player
    game.mark_square("c").should eq false 
  end

  it "returns 'Invalid selection' when a player makes an invalid selection" do
    game = Game.new
    game.mark_square("j").should eq false
  end

  it "determines if the game is over" do
    game = Game.new
    game.mark_square("a")
    game.over?.should eq false
  end

  it "determines if the game is over" do
    game = Game.new
    game.mark_square("a")
    game.mark_square("b")
    game.mark_square("c")
    game.over?.should eq true
  end

  it "determines the winner" do
    game = Game.new
    game.mark_square("a")
    game.mark_square("b")
    game.mark_square("c")
    game.winner.should eq "Player X is the winner!"
  end

  it "returns false if it is not a cat's game" do
    game = Game.new
    game.mark_square("a")
    game.mark_square("b")
    game.mark_square("c")
    game.mark_square("d")
    game.mark_square("e")
    game.mark_square("f")
    game.mark_square("h")
    game.mark_square("i")
    game.cats_game?.should eq false
  end

  it 'returns true if the it is a cat\'s game' do
    game = Game.new
    game.mark_square("a")
    game.mark_square("b")
    game.mark_square("c")
    game.mark_square("d")
    game.mark_square("e")
    game.mark_square("f")
    game.mark_square("g")
    game.mark_square("h")
    game.mark_square("i")
    game.cats_game?.should eq true
  end

  it 'has a computer turn that plays a move' do
    game = Game.new
    game.stub(:rand) {0}
    game.computer_turn.should eq "a"
  end
end