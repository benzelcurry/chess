# TODOs:
# 1. Make board a 2D array of 8 subarrays of length 8
# 2. Arrays will be prepopulated with the pieces
# 3. Make sure it uses the unicode chesspieces accordingly
# 4. Make a piece class that's extended by respective pieces?

class Board
  attr_accessor :board

  X_AXIS = (1..8).to_a.freeze
  Y_AXIS = ('A'..'H').to_a.freeze

  def initialize
    self.board = Array.new(7) { Array.new(8, '_') }
  end

  # Prints the board to the console
  def draw_board
    board.each_with_index do |row, i|
      row_string = ''
      row_string += "#{Y_AXIS[i]}  "
      if i.even?
        row.each_index do |n|
          if n.even?
            row_string += ' '
          else
            row_string += '█'
          end
        end
      else
        row.each_index do |n|
          if n.odd?
            row_string += ' '
          else
            row_string += '█'
          end
        end
      end

      puts row_string
    end

    x_labels = "\n   "
    X_AXIS.each do |i|
      x_labels += i.to_s
    end
    puts x_labels
  end
end
