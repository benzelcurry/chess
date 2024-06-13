class Piece
  attr_accessor :color, :location

  def initialize(color, location)
    # Colors will only be black or white
    self.color = color
    # Location is where the spot on the board is kept and used to draw pieces
    self.location = location
  end
end
