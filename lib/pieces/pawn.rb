# Pawn; extends Piece
class Pawn < Piece
  attr_accessor :icon, :name, :first_turn

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

    if color == 'black'
      legal_move_black?(x_dif)
    else
      legal_move_white?(x_dif)
    end
  end

  private

  def legal_move_black?(movement)
    if first_turn
      self.first_turn = false
      movement <= 2 && movement.positive? ? true : false
    else
      movement <= 1 && movement.positive? ? true : false
    end
  end

  def legal_move_white?(movement)
    if first_turn
      self.first_turn = false
      movement.abs <= 2 && movement.negative? ? true : false
    else
      movement.abs <= 1 && movement.negative? ? true : false
    end
  end
end
