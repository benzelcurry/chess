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

  # Moves the specified piece to target destination
  # Note: Pseudocode in Piece.rb
  # TODO: Will likely need multiple abstractions before being finished
  def move_piece
    # May want to determine legal moves by checking Piece type
    target_piece = nil
    destination = nil

    puts 'Please enter which piece you would like to move'
    loop do
      target_piece = gets.chomp.downcase
      break if valid_coordinate?(target_piece)
    end
    target_piece = translate_coordinates(target_piece)

    puts 'Please enter where you\'d like to move it'
    loop do
      destination = gets.chomp.downcase
      break if valid_coordinate?(destination)
    end
    destination = translate_coordinates(destination)

    # TODO: Add a default color for board squares that stays in tact even after piece is moved
    board[destination[0]][destination[1]] = board[target_piece[0]][target_piece[1]]
    board[target_piece[0]][target_piece[1]] = '_'

    # TODO: Add variables to capture the original coordinate inputs so this output looks cleaner
    puts "#{target_piece} to #{destination}"

    draw_board
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
  # Note: This could be more DRY but there's really no way to make this method pretty
  def draw_row(row, row_number)
    row_string = ''
    if row_number.even?
      row.each_index do |n|
        row_string += if row[n] == '_'
                        n.even? ? ' ' : '█'
                      else
                        row[n].icon
                      end
      end
    else
      row.each_index do |n|
        row_string += if row[n] == '_'
                        n.odd? ? ' ' : '█'
                      else
                        row[n].icon
                      end
      end
    end
    row_string
  end

  # Translates coordinates to array accessor syntax
  def translate_coordinates(coordinate)
    raise ArgumentException "Invalid coordinates: #{coordinate}" unless valid_coordinate?(coordinate)

    [COORD_MAP[coordinate[0].upcase.to_sym].to_i, coordinate[1].to_i - 1]
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
