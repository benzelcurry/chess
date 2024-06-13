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
      row_string += draw_row(row, i)

      puts row_string
    end

    x_labels = "\n   "
    X_AXIS.each { |i| x_labels += i.to_s }
    puts x_labels
  end

  private

  # Helper method used in #draw_board
  def draw_row(row, row_number)
    row_string = ''
    if row_number.even?
      row.each_index { |n| row_string += n.even? ? ' ' : '█' }
    else
      row.each_index { |n| row_string += n.odd? ? ' ' : '█' }
    end
    row_string
  end
end
