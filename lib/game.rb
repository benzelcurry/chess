# Class for running the chess game
class Game
  attr_accessor :turn, :turns_taken

  def initialize
    self.turn = 0
    self.turns_taken = 0
  end
end
