# Rook; extends Piece
class Rook < Piece
  attr_accessor :icon, :name, :first_turn

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♖' : '♜')
    self.name = 'Rook'
  end

  # Defines whether the passed move is a legal move for a rook
  def legal_move?(destination, target)
    # if x changes, y doesnt and vice versa
  end
end
