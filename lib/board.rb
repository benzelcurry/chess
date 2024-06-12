# TODOs:
# 1. Replace draw_board with something that uses the same design but operates differently
# 2. Have it check for pieces (whose positions will be established by default, will need to decide if pieces stored in Board or Player)
# 3. Make sure it uses the unicode chesspieces accordingly

class Board
  def draw_board
    columns = ('A'..'H').to_a
    rows = (1..8).to_a.reverse
    board = ""
  
    # Print column headers
    board += "  " + columns.join(" ") + "\n"
  
    # Print each row with its label
    rows.each do |row|
      board += row.to_s + " " # Row label
      columns.each_with_index do |col, index|
        # Determine whether to print a black or white square
        if (row + index).even?
          board += "█" # Black square
        else
          board += " " # White square
        end
        board += " " # Space between squares
      end
      board += row.to_s + "\n" # Repeat row label at the end of the row
    end
  
    # Print column headers again at the bottom
    board += "  " + columns.join(" ") + "\n"
  
    puts board
  end
end
