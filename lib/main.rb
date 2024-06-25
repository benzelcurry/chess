require_relative('board')
require_relative('pieces/piece')
require_relative('pieces/pawn')

board = Board.new
board.draw_board

black_pieces = [
  black_pawn1 = Pawn.new('black', [1, 0]),
  black_pawn2 = Pawn.new('black', [1, 1]),
  black_pawn3 = Pawn.new('black', [1, 2]),
  black_pawn4 = Pawn.new('black', [1, 3]),
  black_pawn5 = Pawn.new('black', [1, 4]),
  black_pawn6 = Pawn.new('black', [1, 5]),
  black_pawn7 = Pawn.new('black', [1, 6]),
  black_pawn8 = Pawn.new('black', [1, 7])
]

white_pieces = [
  white_pawn1 = Pawn.new('white', [6, 0]),
  white_pawn2 = Pawn.new('white', [6, 1]),
  white_pawn3 = Pawn.new('white', [6, 2]),
  white_pawn4 = Pawn.new('white', [6, 3]),
  white_pawn5 = Pawn.new('white', [6, 4]),
  white_pawn6 = Pawn.new('white', [6, 5]),
  white_pawn7 = Pawn.new('white', [6, 6]),
  white_pawn8 = Pawn.new('white', [6, 7])
]

black_pieces.each do |piece|
  board.position_piece(piece, piece.location)
end

white_pieces.each do |piece|
  board.position_piece(piece, piece.location)
end

# TODO: Ensure that two pieces can't be on the same spot

board.draw_board

board.move_piece
board.move_piece
