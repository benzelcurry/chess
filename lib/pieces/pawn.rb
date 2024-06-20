# Pawn; extends Piece
class Pawn < Piece
  # TODO: Add a property that stores the unicode pawn character
  # Moves the pawn to its desired location

  attr_accessor :icon

  def initialize(color, location)
    super(color, location)
    self.icon = (color == 'white' ? '♙' : '♟')
  end

  def move
    # Split the above input gathering into its own method within Piece
    # May want to extract this logic to Game and determine legal moves by checking Piece type
    target_piece = nil
    destination = nil

    puts 'Please enter which piece you would like to move'
    loop do
      target_piece = gets.chomp.downcase
      break if valid_coordinate?(target_piece)
    end

    puts 'Please enter where you\'d like to move it'
    loop do
      destination = gets.chomp.downcase
      break if valid_coordinate?(destination)
    end

    
  end
end
