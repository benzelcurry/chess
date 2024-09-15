

black_pieces.each do |piece|
  board.position_piece(piece, piece.location)
end

white_pieces.each do |piece|
  board.position_piece(piece, piece.location)
end

board.draw_board

board.move_piece
board.move_piece
