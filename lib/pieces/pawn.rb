# Pawn; extends Piece
class Pawn < Piece
  # TODO: Add a property that stores the unicode pawn character
  # Moves the pawn to its desired location

  attr_accessor :icon

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♙' : '♟')
  end
end
