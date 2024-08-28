# Class for instantiating the board that the game will be played on
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
    X_AXIS.each { |i| x_labels += "#{i.to_s} " }
    puts x_labels
  end

  # Draws/moves a piece on the board
  def position_piece(piece, coordinate)
    # coords = translate_coordinates(coordinate)
    board[coordinate[0]][coordinate[1]] = piece
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
      break if valid_coordinate?(target_piece, true)
    end
    target_piece = translate_coordinates(target_piece)

    puts 'Please enter where you\'d like to move it'
    loop do
      destination = gets.chomp.downcase
      break if valid_coordinate?(destination) &&
               # TODO: Add a check to the below method for legal moves based on target piece
               can_move?(board[target_piece[0]][target_piece[1]], translate_coordinates(destination))
    end
    destination = translate_coordinates(destination)

    board[destination[0]][destination[1]] = board[target_piece[0]][target_piece[1]]
    board[target_piece[0]][target_piece[1]] = '_'

    sleep(1)
    puts "#{reverse_coordinates(target_piece)} to #{reverse_coordinates(destination)}."

    sleep(1)
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
  # TODO: Change this to use whitespace + background colors for the squares per josh's recommendation
  def draw_row(row, row_number)
    row_string = ''
    if row_number.even?
      row.each_index do |n|
        row_string += if row[n] == '_'
                        n.even? ? '  ' : '██'
                      else
                        "#{row[n].icon} "
                      end
      end
    else
      row.each_index do |n|
        row_string += if row[n] == '_'
                        n.odd? ? '  ' : '██'
                      else
                        "#{row[n].icon} "
                      end
      end
    end
    row_string
  end

  # Translates coordinates to array accessor syntax
  def translate_coordinates(coordinate)
    # Bottom line of code can maybe be deleted; I believe input should already be validated by the time it makes it to this method
    # raise ArgumentException "Invalid coordinates: #{coordinate}" unless valid_coordinate?(coordinate)

    [COORD_MAP[coordinate[0].upcase.to_sym].to_i, coordinate[1].to_i - 1]
  end

  # Reverts coordinates back into human readible syntax
  def reverse_coordinates(coordinate)
    "#{COORD_MAP.key(coordinate[0])}#{coordinate[1] + 1}"
  end

  # Validates target piece/destination input
  def valid_coordinate?(input, first_target=false)
    if input.length == 2 && input[0].match(/[a-h]/) && input[1].match(/[1-8]/)
      coords = translate_coordinates(input)
      if first_target && board[coords[0]][coords[1]] == '_'
        puts 'You must select a square that contains a piece'
        false
      else
        true
      end
    else
      puts 'Destination must be in the format [a-h][1-8] (e.g. B7, D2, etc.)'
      false
    end
  end

  # Checks to see if a space is open and a legal move
  def can_move?(piece, coordinate)
    target = board[coordinate[0]][coordinate[1]]
    # vertical_blocker = check_path_vertical(piece, coordinate)

    vertical_blocker = piece.location[1] == coordinate[1] && check_path_vertical(piece, coordinate)
    horizontal_blocker = piece.location[0] == coordinate[0] && check_path_horizontal(piece, coordinate)
    diagonal_blocker = vertical_blocker == false && horizontal_blocker == false &&
                                           check_path_diagonal(piece, coordinate) &&
                                           piece.name != 'Knight'

    # Modify below line to check for all blockers
    # TODO: Check if piece can move before checking for blockers? Might complicate things with pawns
    if !piece.legal_move?(coordinate, target)
      puts "#{piece.name}s can't move like that. Please try again."
      false
    elsif vertical_blocker || horizontal_blocker || diagonal_blocker
      puts "There's a piece in your way. Please enter another coordinate."
      false
    elsif target == '_'
      piece.location = coordinate
      true
    elsif target.color == piece.color
      puts 'Cannot move to a square occupied by the same color. Please try again.'
      false
    else
      target.location = nil
      piece.location = coordinate

      # NOTE: Could be a bug here with the previous piece not being deleted correctly; look out in future
      puts "#{reverse_coordinates(coordinate)} captured."
      board[coordinate[0]][coordinate[1]] = '_'
      true
    end
  end

  # Checks for the first piece in a path for pieces that move vertically (rook, queen, pawn)
  def check_path_vertical(moving_piece, destination)
    moving_piece_x = moving_piece.location[0]
    moving_piece_y = moving_piece.location[1]
    first_blocker = nil

    return first_blocker if moving_piece_y != destination[1]

    while moving_piece_x != destination[0]
      if board[moving_piece_x][moving_piece_y] != '_' && moving_piece_x != moving_piece.location[0]
        first_blocker = board[moving_piece_x][moving_piece_y]
        break
      elsif moving_piece_x < destination[0]
        moving_piece_x += 1
      else
        moving_piece_x -= 1
      end
    end

    first_blocker
  end

  # Checks for the first piece in a path for pieces that move horizontally (rook, queen)
  def check_path_horizontal(moving_piece, destination)
    moving_piece_x = moving_piece.location[0]
    moving_piece_y = moving_piece.location[1]
    first_blocker = nil

    return first_blocker if moving_piece_x != destination[0]

    while moving_piece_y != destination[1]
      if board[moving_piece_x][moving_piece_y] != '_' && moving_piece_y != moving_piece.location[1]
        first_blocker = board[moving_piece_x][moving_piece_y]
        break
      elsif moving_piece_y < destination[1]
        moving_piece_y += 1
      else
        moving_piece_y -= 1
      end
    end

    first_blocker

    # TODO: Write method that looks at the x-val of each column; return nil if nothing in path, otherwise return coordinate and/or piece
    # TODO: Remove the false; is a placeholder for diagonal_blocker in #can_move?
    # false
  end

  # Checks for the first piece in a path for pieces that move diagonally (bishop, queen)
  def check_path_diagonal(moving_piece, destination)
    x = moving_piece.location[0]
    y = moving_piece.location[1]
    first_blocker = nil

    while [x, y] != destination
      if board[x][y] != '_' && x != moving_piece.location[0] && y != moving_piece.location[1]
        first_blocker = board[x][y]
        break
      end

      x < destination[0] ? x += 1 : x -= 1
      y < destination[1] ? y += 1 : y -= 1
    end

    first_blocker
  end
end
