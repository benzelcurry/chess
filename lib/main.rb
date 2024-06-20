require_relative('board')
require_relative('pieces/piece')
require_relative('pieces/pawn')

board = Board.new
board.draw_board

white_pawn = Pawn.new('white', 'below')
black_pawn = Pawn.new('black', 'above')

puts white_pawn.icon
puts black_pawn.icon

white_pawn.move
