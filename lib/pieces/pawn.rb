# Pawn; extends Piece
class Pawn < Piece
  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♙' : '♟')
    self.name = 'Pawn'
    self.first_turn = true
  end

  # Defines whether the passed move is a legal move for a pawn
  # TODO: Fix this and read how pawns should be allowed to move (will be different based on color)
  def legal_move?(destination)
    x_dif = destination[0] - location[0]

    if first_turn
      x_dif <= 2 && x_dif.positive? ? true : false
    else
      x_dif <= 1 && x_dif.positive? ? true : false
    end
  end
end
