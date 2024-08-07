# Bishop; extends Piece
class Bishop < Piece
  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♗' : '♝')
  end
end
