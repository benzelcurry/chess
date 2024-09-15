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
      Rook.new(color, [back_row, 0]), Rook.new(color, [back_row, 7]),
      Knight.new(color, [back_row, 1]), Knight.new(color, [back_row, 6]),
      Bishop.new(color, [back_row, 2]), Bishop.new(color, [back_row, 5]),
      Queen.new(color, [back_row, 3]),
      King.new(color, [back_row, 4])
    ]

    pawns = (0..7).map { |i| Pawn.new(color, [pawn_row, i]) }

    (pieces + pawns).each { |piece| board.position_piece(piece, piece.location) }
  end

  # Game loop
  def play
    board.draw_board

    while true
      piece = choose_piece
      destination = choose_destination(board.translate_coordinates(piece))

      next if destination == 'cancel'

      board.move_piece(board.translate_coordinates(piece), board.translate_coordinates(destination))

      self.turn = turn.zero? ? 1 : 0
      board.draw_board
    end
  end

  private

  # Chooses the piece that will be moved
  def choose_piece
    input = nil

    puts 'Please enter which piece you would like to move'

    loop do
      input = gets.chomp.downcase
      break if board.valid_coordinate?(input, turn, true)
    end

    input
  end

  # Chooses where the piece will be moved
  def choose_destination(target)
    input = nil

    puts 'Please enter where you\'d like to move it'
    puts 'Enter "cancel" if you\'d like to select a new piece to move'

    loop do
      input = gets.chomp.downcase
      break if (board.valid_coordinate?(input, turn) &&
               board.can_move?(board.board[target[0]][target[1]], board.translate_coordinates(input))) ||
               input == 'cancel'
    end

    input
  end
end
