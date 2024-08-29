# Queen; extends Piece
class Queen < Piece
  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = color == 'white' ? '♕' : '♛'
    self.name = 'Queen'
  end
end
