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

white_pawn_1 = Pawn.new('white', 'A1')
white_pawn_2 = Pawn.new('white', 'A2')
white_pawn_3 = Pawn.new('white', 'A3')
white_pawn_4 = Pawn.new('white', 'A4')
white_pawn_5 = Pawn.new('white', 'A5')
white_pawn_6 = Pawn.new('white', 'A6')
white_pawn_7 = Pawn.new('white', 'A7')
white_pawn_8 = Pawn.new('white', 'A8')
