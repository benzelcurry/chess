# Rook; extends Piece
class Rook < Piece
  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♖' : '♜')
    self.name = 'Rook'
  end

  # Defines whether the passed move is a legal move for a rook
  def legal_move?(destination, target)
    x_dif = destination[0] - location[0]
    y_dif = destination[1] - location[1]

    x_dif.zero? || y_dif.zero? ? true : false
  end
end
