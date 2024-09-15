require_relative('board')
require_relative('pieces/piece')
require_relative('pieces/pawn')
require_relative('pieces/rook')
require_relative('pieces/bishop')
require_relative('pieces/knight')
require_relative('pieces/queen')
require_relative('pieces/king')

# Class for running the chess game
class Game
  attr_accessor :turn, :turns_taken, :board

  def initialize
    self.turn = 0
    self.turns_taken = 0
    self.board = Board.new

    setup_pieces
  end

  def setup_pieces
    place_pieces('black', 0, 1)
    place_pieces('white', 7, 6)
  end

  def place_pieces(color, back_row, pawn_row)
    pieces = [
      Rook.new(color, [back_row, 0]), Rook.new(color, back_row, 7),
      Knight.new(color, [back_row, 1]), Knight.new(color, [back_row, 6]),
      Bishop.new(color, [back_row, 2]), Bishop.new(color, [back_row, 5]),
      Queen.new(color, [back_row, 3]),
      King.new(color, [back_row, 4])
    ]

    pawns = (0..7).map { |i| Pawn.new(color, [pawn_row, i]) }

    (pieces + pawns).each { |piece| board.position_piece(piece, piece.location) }
  end
end
