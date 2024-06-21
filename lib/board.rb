# TODOs:
# 2. Arrays will be prepopulated with the pieces
# 3. Make sure it uses the unicode chesspieces accordingly
# 4. Make a piece class that's extended by respective pieces?

class Board
  attr_accessor :board

  X_AXIS = (1..8).to_a.freeze
  Y_AXIS = ('A'..'H').to_a.freeze

  def initialize
    self.board = Array.new(8) { Array.new(8, '_') }
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

  # Draws/moves a piece on the board
  def position_piece(piece, coordinate)
    coords = translate_coordinates(coordinate)
    board[coords[0]][coords[1]] = piece
  end

  private

  COORD_MAP = {
    A: 0,
    B: 1,
    C: 2,
    D: 3,
    E: 4,
    F: 5,
    G: 6,
    H: 7
  }

  # Helper method used in #draw_board for drawing the rows
  # TODO: May need to be rewritten with additional abstractions to properly draw pieces
  def draw_row(row, row_number)
    row_string = ''
    if row_number.even?
      # row.each_index { |n| row_string += n.even? ? ' ' : '█' }
      row.each_index do |n|
        if row[n] == '_'
          row_string += n.even? ? ' ' : '█'
        else
          row_string += row[n].icon
        end
      end
    else
      # row.each_index { |n| row_string += n.odd? ? ' ' : '█' }
      row.each_index do |n|
        if row[n] == '_'
          row_string += n.odd? ? ' ' : '█'
        else
          row_string += row[n].icon
        end
      end
    end
    row_string
  end

  # Translates coordinates to array accessor syntax
  def translate_coordinates(coordinate)
    raise ArgumentException "Invalid coordinates: #{coordinate}" unless valid_coordinate?(coordinate)

    [COORD_MAP[coordinate[0]].to_i, coordinate[1].to_i - 1]
  end

  # Validates target piece/destination input
  def valid_coordinate?(input)
    if input.length == 2 && input[0].match(/[a-h]/) && input[1].match(/[1-8]/)
      true
    else
      puts 'Destination must be in the format [a-h][1-8] (e.g. B7, D2, etc.)'
      false
    end
  end
end
