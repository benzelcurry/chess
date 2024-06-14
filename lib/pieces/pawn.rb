# Pawn; extends Piece
class Pawn < Piece
  # TODO: Add a property that stores the unicode pawn character
  # Moves the pawn to its desired location
  def move
    # Split the above input gathering into its own method within Piece
    puts 'Please enter which piece you would like to move'
    puts 'Please enter where you\'d like to move it'
    destination = ''
    until valid_destination?(destination) { destination = gets.chomp.downcase }

  end
end
