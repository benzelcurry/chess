require_relative('board')

# King; extends Piece
class King < Piece
  attr_accessor :icon, :name

  def initialize(color, location)
    super(color, location)
    self.icon = color == 'white' ? '♔' : '♚'
    self.name = 'King'
  end

  # Defines whether the passed move is a legal move for a king
  def legal_move?(destination, _target)
    x_dif = (destination[0] - location[0]).abs
    y_dif = (destination[1] - location[1]).abs

    x_dif <= 1 && y_dif <= 1
  end

  # Checks to see if king is currently in check
  def in_check?(board)
    x = location[0]
    y = location[1]

    knight_spots = [
      [x + 2, y + 1],
      [x + 2, y - 1],
      [x - 2, y + 1],
      [x - 2, y - 1],
      [x + 1, y + 2],
      [x + 1, y - 2],
      [x - 1, y + 2],
      [x - 1, y - 2]
    ]

    knight_spots.each do |spot|
      return true if board[spot[0]][spot[1]]&.name == 'knight'
    end

    straight_blockers = [
      board.check_path_horizontal(self, [0, y]),
      board.check_path_horizontal(self, [7, y]),
      board.check_path_vertical(self, [x, 0]),
      board.check_path_vertical(self, [x, 7])
    ]

    straight_blockers.each do |blocker|
      return true if blocker&.name == 'rook' || blocker&.name == 'queen'
    end

    diagonal_blockers = [
      # TODO: Will need to do some math to calculate what the diagonal options relating to piece are
    ]

    # TODO: Checkk all diagonal_blockers for pawns, bishops, and queens of opposing colors
    # NOTE: Pawns can only capture depending on which direction they're in
  end

  # TODO: Add a method that calls #in_check? for every possible move the king can make and then
  #       stores them in a new variable for the piece. Then modify #legal_move? to exclude
  #       moves that would fall in this list. End the game if the king is in checkmate. Write
  #       messages that announce when a king is in check.
end
