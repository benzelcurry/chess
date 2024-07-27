# Class for instantiating the board that the game will be played on
class Board
  attr_accessor :board

  # If X_AXIS and Y_AXIS are mainly for bounds then we can leave them as ranges instead of converting them to arrays
  X_AXIS = (1..8).to_a.freeze
  Y_AXIS = ('A'..'H').to_a.freeze

  def initialize
    #### A 2D array is more efficient than using a hash, but the array is tiny so it doesn't matter
    #### A hash of points/vectors or a class wrapping a 2d array would be much nicer to manipulate
    self.board = Array.new(8) { Array.new(8, '_') }
  end

  # Drawing the board becomes simpler if we maintain a 2D array instead of adding logic
  # Prints the board to the console
  def draw_board
    board.each_with_index do |row, i|
      # We can do puts "#{Y_AXIS[i]}  #{draw_row(row, i)}"
      row_string = ''
      row_string += "#{Y_AXIS[i]}  "
      row_string += draw_row(row, i)

      puts row_string
    end

    x_labels = "\n   "
    X_AXIS.each { |i| x_labels += "#{i.to_s} " }
    puts x_labels
  end


  ### In general we can simplify handling positions if we use a vector class
  ### https://ruby-doc.org/stdlib-3.0.0/libdoc/matrix/rdoc/Vector.html

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
    target_piece = nil # null assignments are a code smell
    destination = nil

    puts 'Please enter which piece you would like to move'
    ### Avoid loop do and do while in other languages
    ### In ruby we can express this as
    # target_piece = gets.chomp.downcase until valid_coordinate? target_piece
    #
    loop do
      target_piece = gets.chomp.downcase
      break if valid_coordinate?(target_piece)
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

    puts "#{reverse_coordinates(target_piece)} to #{reverse_coordinates(destination)}."

    draw_board
  end

  private

  # We can do
  # COORD_MAP = ('A' .. 'H').each_with_index
  #               .to_h
  #               .freeze
  #
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
  def draw_row(row, row_number) # Would something like column_index or height be more appropriate? kinda confusing
    ##
    # This can be simplified with some more advanced functional programming concepts
    #
    # pattern = ['  ', '██'].cycle.lazy
    # pattern = pattern.drop(1) if row_number.odd?
    #
    # row.zip(pattern)
    #    .map { |icon, tile| icon == '_' ? tile : icon }

    ##
    # Another Version
    #
    # row.each_with_index.map do |icon, idx|
    #   if icon != '_'
    #     icon
    #   else if idx.even? == rown_number.even?
    #     '  '
    #   else
    #     '██'
    #  end
    # end
    #
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
    raise ArgumentException "Invalid coordinates: #{coordinate}" unless valid_coordinate?(coordinate)

    # the first .to_i is redundent
    [COORD_MAP[coordinate[0].upcase.to_sym].to_i, coordinate[1].to_i - 1]
  end

  # We can simplify this by keeping an inversion of the map since it is small
  # Ruby's hash also has a convient invert method

  # Reverts coordinates back into human readible syntax
  def reverse_coordinates(coordinate)
    "#{COORD_MAP.key(coordinate[0])}#{coordinate[1] + 1}"
  end

  # Validates target piece/destination input
  def valid_coordinate?(input)
    ##
    # Would be nicer to throw here instead of at the call sight imo
    #
    # letter, num = input
    # unless input.length == 2 && /[a-h]/i =~ letter && /[1-8]/ =~ num
    #   puts 'Destination must be in the format [a-h][1-8] (e.g. B7, D2, etc.)'
    #   raise ArgumentException "Invalid coordinates: #{coordinate}" unless valid_coordinate?(coordinate)
    # end
    #
    # true
    #
    if input.length == 2 && input[0].match(/[a-h]/) && input[1].match(/[1-8]/)
      true
    else
      puts 'Destination must be in the format [a-h][1-8] (e.g. B7, D2, etc.)'
      false
    end
  end

  # Checks to see if a space is open and a legal move
  def can_move?(piece, coordinate)
    target = board[coordinate[0]][coordinate[1]]
    vertical_blocker = check_path_vertical(piece, coordinate)

    # Modify below line to check for all blockers
    if vertical_blocker
      puts "There's a piece in your way. Please enter another coordinate."
      false
    elsif !piece.legal_move?(coordinate, target)
      puts "#{piece.name}s can't move like that. Please try again."
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

    while moving_piece_x < destination[0] - 1
      if board[moving_piece_x][moving_piece_y] != '_'
        first_blocker = board[moving_piece_x][moving_piece_y]
        break
      end
    end

    first_blocker
  end

  # Checks for the first piece in a path for pieces that move horizontally (rook, queen)
  def check_path_horizontal(moving_piece, destination)
    # TODO: Write method that looks at the x-val of each column; return nil if nothing in path, otherwise return coordinate and/or piece
  end

  # Checks for the first piece in a path for pieces that move diagonally (bishop, queen)
  def check_path_diagonal(moving_piece, destination)
    # TODO: Write method that looks at both the x-val and y-val of each square in path; return nil if nothing in path, otherwise return coordinate and/or piece
  end
end
