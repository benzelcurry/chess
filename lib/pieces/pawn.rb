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

  # Idea: Abstract the logic for captures (when y_dif is positive) to their own helper method
  def legal_move_black?(x_dif, y_dif, target_color, is_king)
    if y_dif.abs.positive? && target_color != 'white'
      false
    elsif is_king
      puts 'A pawn cannot take a king'
      false
    elsif first_turn
      first_move_black(x_dif, y_dif, target_color)
    else
      subsequent_move(x_dif, y_dif, target_color, 'black')
    end
  end

  def legal_move_white?(x_dif, y_dif, target_color, is_king)
    if y_dif.abs.positive? && target_color != 'black'
      false
    elsif is_king
      puts 'A pawn cannot take a king'
      false
    elsif first_turn
      first_move_white(x_dif, y_dif, target_color)
    else
      subsequent_move(x_dif, y_dif, target_color, 'white')
    end
  end

  def first_move_black(x_dif, y_dif, target_color)
    if target_color.nil?
      if x_dif <= 2 && x_dif.positive? && target_color.nil?
        self.first_turn = false
        true
      else
        false
      end
    else
      x_dif == 1 && y_dif.abs == 1 ? true : false
    end
  end

  def first_move_white(x_dif, y_dif, target_color)
    if target_color.nil?
      if x_dif.abs <= 2 && x_dif.negative? && target_color.nil?
        self.first_turn = false
        true
      else
        false
      end
    else
      x_dif == -1 && y_dif.abs == 1 ? true : false
    end
  end

  def subsequent_move(x_dif, y_dif, target_color, self_color)
    if y_dif.zero? && x_dif.abs == 1
      if self_color == 'black'
        x_dif.positive? ? true : false
      else
        x_dif.negative? ? true : false
      end
    else
      y_dif.abs == 1 && target_color != self_color ? true : false
    end
  end
end
