require_relative('../board')

# King; extends Piece
class King < Piece
  attr_accessor :icon, :name, :available_spots

  def initialize(color, location)
    super(color, location)
    self.icon = color == 'white' ? '♔' : '♚'
    self.name = 'King'
    self.available_spots = []
  end

  # Defines whether the passed move is a legal move for a king
  def legal_move?(destination, _target)
    x_dif = (destination[0] - location[0]).abs
    y_dif = (destination[1] - location[1]).abs

    x_dif <= 1 && y_dif <= 1
  end

  # Checks to see if king is currently in check
  # TODO: Abstract much of the logic; this method is foul as-is
  def in_check?(board, target_x=nil, target_y=nil)
    x = location[0]
    y = location[1]

    if target_x && target_y
      x = target_x
      y = target_y
    end

    opposite_color = color == 'white' ? 'black' : 'white'

    knight_spots = [
      safe_access(board, x + 2, y + 1),
      safe_access(board, x + 2, y - 1),
      safe_access(board, x - 2, y + 1),
      safe_access(board, x - 2, y - 1),
      safe_access(board, x + 1, y + 2),
      safe_access(board, x + 1, y - 2),
      safe_access(board, x - 1, y + 2),
      safe_access(board, x - 1, y - 2)
    ]

    knight_spots.each do |spot|
      if spot.is_a?(Knight) && spot.color == opposite_color
        return true
      end
    end

    straight_blockers = [
      board.check_path_horizontal(self, [x, 0]),
      board.check_path_horizontal(self, [x, 7]),
      board.check_path_vertical(self, [0, y]),
      board.check_path_vertical(self, [7, y])
    ]

    straight_blockers.each do |blocker|
      if (blocker.is_a?(Rook) || blocker.is_a?(Queen)) && blocker&.color == opposite_color
        return true
      end
    end

    diagonal_bounds = {
      top_left: [x - [x, y].min, y - [x, y].min],
      bottom_right: [x + [7 - x, 7 - y].min, y + [7 - x, 7 - y].min],
      top_right: [x - [x, 7 - y].min, y + [x, 7 - y].min],
      bottom_left: [x + [7 - x, y].min, y - [7 - x, y].min]
    }

    diagonal_blockers = [
      board.check_path_diagonal(self, diagonal_bounds[:top_left]),
      board.check_path_diagonal(self, diagonal_bounds[:top_right]),
      board.check_path_diagonal(self, diagonal_bounds[:bottom_left]),
      board.check_path_diagonal(self, diagonal_bounds[:bottom_right])
    ]

    diagonal_blockers.each do |blocker|
      if (blocker.is_a?(Bishop) || blocker.is_a?(Queen)) && blocker&.color == opposite_color
        return true
      end
    end

    pawn_blockers = [
      safe_access(board, x + 1, y + 1),
      safe_access(board, x + 1, y - 1),
      safe_access(board, x - 1, y + 1),
      safe_access(board, x - 1, y - 1)
    ]

    if color == 'black'
      pawn_blockers[0..1].each do |blocker|
        return true if blocker.is_a?(Pawn) && blocker&.color == opposite_color
      end
    else
      pawn_blockers[2..3].each do |blocker|
        return true if blocker.is_a?(Pawn) && blocker&.color == opposite_color
      end
    end

    false
  end

  # TODO: Add a method that calls #in_check? for every possible move the king can make and then
  #       stores them in a new variable for the piece. Then modify #legal_move? to exclude
  #       moves that would fall in this list. End the game if the king is in checkmate. Write
  #       messages that announce when a king is in check.

  def checkmate?(board)
    checked_spots = []

    available_spots.each do |spot|
      checked_spots.push(in_check?(board, spot[0], spot[1]))
    end

    in_check?(board) && check_spots.all? { |item| item == true }
  end

  def find_legal_moves(board)
    x = location[0]
    y = location[1]

    potential_moves = [
      safe_access(board, x - 1, y + 1),
      safe_access(board, x, y + 1),
      safe_access(board, x + 1, y + 1),
      safe_access(board, x + 1, y),
      safe_access(board, x + 1, y - 1),
      safe_access(board, x, y - 1),
      safe_access(board, x - 1, y - 1),
      safe_access(board, x - 1, y)
    ]

    # Open spots are returned from #safe_access in the form of an array
    open_spots = potential_moves.select { |item| item.is_a?(Array) }

    self.available_spots = open_spots
  end

  private

  def safe_access(board, x, y)
    return nil if x.negative? || x > 7 || y.negative? || y > 7

    if board.board[x][y] == '_'
      [x, y]
    else
      board.board[x][y]
    end
  end
end
