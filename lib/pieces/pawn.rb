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
  def legal_move?(destination, target)
    x_dif = destination[0] - location[0]
    y_dif = destination[1] - location[1]
    target_color = target == '_' ? nil : target.color
    is_king = target == '_' ? false : (target.name == 'King')

    if color == 'black'
      legal_move_black?(x_dif, y_dif, target_color, is_king)
    else
      legal_move_white?(x_dif, y_dif, target_color, is_king)
    end
  end

  private

  # TODO: Clean this up, make abstractions, then copy over to #legal_move_white?
  # TODO: Prevent them from capturing if target is a king and provide a unique message
  # Idea: Abstract the logic for captures (when y_dif is positive) to their own helper method
  def legal_move_black?(x_dif, y_dif, target_color, is_king)
    if y_dif.abs.positive? && target_color != 'white'
      false
    elsif is_king
      puts 'A pawn cannot take a king'
      false
    elsif first_turn
      if target_color.nil?
        if x_dif <= 2 && x_dif.positive? && target_color.nil?
          self.first_turn = false
          true
        else
          false
        end
      elsif target
      else
        x_dif == 1 && x_dif.positive? && y_dif.abs == 1 ? true : false
      end
    elsif x_dif <= 1 && x_dif.positive?
      if !y_dif.zero?
        true
      else
        y_dif.abs == 1 && target_color == 'white' ? true : false
      end
    end
  end

  def legal_move_white?(x_dif, y_dif, target_color, is_king)
    if first_turn
      if x_dif.abs <= 2 && x_dif.negative?
        self.first_turn = false
        true
      else
        false
      end
    else
      x_dif.abs <= 1 && x_dif.negative? ? true : false
    end
  end
end
