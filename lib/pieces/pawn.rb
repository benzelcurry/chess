# Pawn; extends Piece
class Pawn < Piece
  # TODO: Add a property that stores the unicode pawn character
  # Moves the pawn to its desired location

  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♙' : '♟')
    self.name = 'Pawn'
  end

  # Defines whether the passed move is a legal move for a pawn
  # TODO: Fix this and read how pawns should be allowed to move (will be different based on color)
  def legal_move?(destination)
    if (destination[0] == location[0] + 1 || destination[0] == location[1] - 1) &&
       (destination[1] == location[1] + 1 || destination[1] == location[1] - 1)
      true
    else
      false
    end
  end
end
