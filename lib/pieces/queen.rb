# Queen; extends Piece
class Queen < Piece
  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = color == 'white' ? '♕' : '♛'
    self.name = 'Queen'
  end

  # Defines whether the passed move is a legal move for a queen
  def legal_move?(destination, _target)
    x_dif = (destination[0] - location[0]).abs
    y_dif = (destination[1] - location[1]).abs
    diagonal_move = x_dif / y_dif == 1
    straight_move = x_dif.zero? || y_dif.zero?

    diagonal_move || straight_move
  end
end
