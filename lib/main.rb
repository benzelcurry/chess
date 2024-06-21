require_relative('board')
require_relative('pieces/piece')
require_relative('pieces/pawn')

board = Board.new
board.draw_board

black_pawn_1 = Pawn.new('black', 'A1')
black_pawn_2 = Pawn.new('black', 'A2')
black_pawn_3 = Pawn.new('black', 'A3')
black_pawn_4 = Pawn.new('black', 'A4')
black_pawn_5 = Pawn.new('black', 'A5')
black_pawn_6 = Pawn.new('black', 'A6')
black_pawn_7 = Pawn.new('black', 'A7')
black_pawn_8 = Pawn.new('black', 'A8')

white_pawn_1 = Pawn.new('white', 'H1')
white_pawn_2 = Pawn.new('white', 'H2')
white_pawn_3 = Pawn.new('white', 'H3')
white_pawn_4 = Pawn.new('white', 'H4')
white_pawn_5 = Pawn.new('white', 'H5')
white_pawn_6 = Pawn.new('white', 'H6')
white_pawn_7 = Pawn.new('white', 'H7')
white_pawn_8 = Pawn.new('white', 'H8')

board.position_piece(white_pawn_1, white_pawn_1.location.downcase)
board.position_piece(white_pawn_2, white_pawn_2.location.downcase)

# TODO: Put pieces into an array and loop through to draw them
# TODO: Ensure that two pieces can't be on the same spot

board.draw_board
