require_relative('board')
require_relative('pieces/piece')
require_relative('pieces/pawn')
require_relative('pieces/rook')
require_relative('pieces/bishop')
require_relative('pieces/knight')
require_relative('pieces/queen')
require_relative('pieces/king')

board = Board.new

black_pieces = [
  black_pawn1 = Pawn.new('black', [1, 0]),
  black_pawn2 = Pawn.new('black', [1, 1]),
  black_pawn3 = Pawn.new('black', [1, 2]),
  black_pawn4 = Pawn.new('black', [1, 3]),
  black_pawn5 = Pawn.new('black', [1, 4]),
  black_pawn6 = Pawn.new('black', [1, 5]),
  black_pawn7 = Pawn.new('black', [1, 6]),
  black_pawn8 = Pawn.new('black', [1, 7]),
  black_rook1 = Rook.new('black', [0, 0]),
  black_rook2 = Rook.new('black', [0, 7]),
  black_knight1 = Knight.new('black', [0, 1]),
  black_knight2 = Knight.new('black', [0, 6]),
  black_bishop1 = Bishop.new('black', [0, 2]),
  black_bishop2 = Bishop.new('black', [0, 5]),
  black_queen = Queen.new('black', [0, 3]),
  black_king = King.new('black', [0, 4])
  # black_rook = Rook.new('black', [2, 7]),
  # black_bishop = Bishop.new('black', [2, 0]),
  # black_knight = Knight.new('black', [2, 2]),
  # black_queen = Queen.new('black', [3, 0]),
  # black_king = King.new('black', [3, 5])
]

white_pieces = [
  white_pawn1 = Pawn.new('white', [6, 0]),
  white_pawn2 = Pawn.new('white', [6, 1]),
  white_pawn3 = Pawn.new('white', [6, 2]),
  white_pawn4 = Pawn.new('white', [6, 3]),
  white_pawn5 = Pawn.new('white', [6, 4]),
  white_pawn6 = Pawn.new('white', [6, 5]),
  white_pawn7 = Pawn.new('white', [6, 6]),
  white_pawn8 = Pawn.new('white', [6, 7]),
  white_rook1 = Rook.new('white', [7, 0]),
  white_rook2 = Rook.new('white', [7, 7]),
  white_knight1 = Knight.new('white', [7, 1]),
  white_knight2 = Knight.new('white', [7, 6]),
  white_bishop1 = Bishop.new('white', [7, 2]),
  white_bishop2 = Bishop.new('white', [7, 5]),
  white_queen = Queen.new('white', [7, 3]),
  white_king = King.new('white', [7, 4])
  # white_pawn_DEL_ME = Pawn.new('white', [2, 2]),
  # white_rook1 = Rook.new('white', [5, 7]),
  # white_knight = Knight.new('white', [4, 0]),
  # white_queen = Queen.new('white', [4, 7]),
  # white_king = King.new('white', [4, 5])
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
