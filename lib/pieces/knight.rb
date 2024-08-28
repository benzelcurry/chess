# Knight; extends Piece
class Knight < Piece
  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♘' : '♞')
    self.name = 'Knight'
  end

  # Defines whether the passed move is a legal move for a knight
  def legal_move?(destination, _target)
    x_dif = (destination[0] - location[0]).abs
    y_dif = (destination[1] - location[1]).abs
    split = (x_dif - y_dif).abs

    p [x_dif, y_dif, split]

    split == 1
  end
end
