require_relative('board')
require_relative('pieces/piece')
require_relative('pieces/pawn')

board = Board.new
board.draw_board

black_pieces = [
  black_pawn1 = Pawn.new('black', 'B1'),
  black_pawn2 = Pawn.new('black', 'B2'),
  black_pawn3 = Pawn.new('black', 'B3'),
  black_pawn4 = Pawn.new('black', 'B4'),
  black_pawn5 = Pawn.new('black', 'B5'),
  black_pawn6 = Pawn.new('black', 'B6'),
  black_pawn7 = Pawn.new('black', 'B7'),
  black_pawn8 = Pawn.new('black', 'B8')
]

white_pieces = [
  white_pawn1 = Pawn.new('white', 'G1'),
  white_pawn2 = Pawn.new('white', 'G2'),
  white_pawn3 = Pawn.new('white', 'G3'),
  white_pawn4 = Pawn.new('white', 'G4'),
  white_pawn5 = Pawn.new('white', 'G5'),
  white_pawn6 = Pawn.new('white', 'G6'),
  white_pawn7 = Pawn.new('white', 'G7'),
  white_pawn8 = Pawn.new('white', 'G8')
]

# board.position_piece(white_pawn1, white_pawn1.location.downcase)
# board.position_piece(white_pawn2, white_pawn2.location.downcase)

black_pieces.each do |piece|
  board.position_piece(piece, piece.location.downcase)
end

white_pieces.each do |piece|
  board.position_piece(piece, piece.location.downcase)
end

# TODO: Ensure that two pieces can't be on the same spot

board.draw_board
