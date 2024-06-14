# Superclass that will be inherited by all other chess pieces
class Piece
  attr_accessor :color, :location

  def initialize(color, location)
    # Colors will only be black or white
    self.color = color
    # Location is where the spot on the board is kept and used to draw pieces
    self.location = location
  end

  # (Attempts to) move piece to target destination
  def move
    # Destination will be converted from letter-number format to fit 2D array (use a hash?)
    # Pseucodode for checking if move is legal to be overridden by subclasses:
  #   if piece can move to spot
  #     if spot is empty
  #       puts "[piece] to [destination]"
  #     elsif something in way (ONLY FOR ROOKS, BISHOPS, AND QUEENS)
  #       puts "Illegal move - Must capture piece blocking your path"
  #     elsif piece of same color on spot
  #       puts "Illegal move - Piece of same color already on spot"
  #     else
  #       remove opponent piece from board
  #       puts "[piece] captures [destination]"
  #     end
  #   else
  #     puts "Illegal move - Piece can't move like that"
  #   end
    raise NotImplementedError
  end

  private

  # Validates target destination input; meant to be used in subclasses
  def valid_destination?(input)
    if input.length == 2 && input[0].match(/[a-h]/) && input[1].match(/[1-8]/)
      true
    else
      false
    end
  end
end
