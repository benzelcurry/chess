require_relative('board')
require_relative('pieces/piece')
Dir[File.join(__dir__, 'pieces', '*.rb')].sort.each do |file|
  require_relative file unless file.end_with?('piece.rb')
end

# Class for running the chess game
class Game
  attr_accessor :turn, :turns_taken, :board, :white_king, :black_king

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

    board.position_piece(Queen.new('white', [2, 0]), [2, 0])
    # board.position_piece(King.new('black', [5, 4]), [5, 4])

    if color == 'white'
      self.white_king = pieces.find { |piece| piece.is_a?(King) }
    else
      self.black_king = pieces.find { |piece| piece.is_a?(King) }
    end
  end

  # Game loop
  def play
    board.draw_board

    while true
      piece = choose_piece
      destination = choose_destination(board.translate_coordinates(piece))
      kings = [black_king, white_king]
      colors = %w[Black White]

      next if destination == 'cancel'

      board.move_piece(board.translate_coordinates(piece), board.translate_coordinates(destination))

      puts "#{colors[turn]} is in check" if kings[turn].in_check?(board)

      self.turn = turn.zero? ? 1 : 0
      self.turns_taken += 1
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
