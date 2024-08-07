# Bishop; extends Piece
class Bishop < Piece
  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♗' : '♝')
    self.name = 'Bishop'
  end

  # Defines whether the passed move is a legal move for a bishop
  def legal_move?(destination, _target)
    x_dif = (destination[0] - location[0]).abs
    y_dif = (destination[1] - location[1]).abs

    y_dif.zero? ? false : x_dif / y_dif == 1
  end
end
