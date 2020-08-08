# Board class
  # initialize: create board
  # winner?
  # 
# Player class

class Board 
  attr_accessor :board 

  def initialize
    @board = [["", "", ""], ["", "", ""], ["", "", ""]]
  end

  def show
    puts "[ ] [ ] [ ]" 
    puts "[ ] [ ] [ ]"  
    puts "[ ] [ ] [ ]"  
  end

  def winner
    if (
      winning_row? ||
      winning_column? ||
      winning_diagonal? 
    ) 
      true
    end

    false
  end

  def winning_row?
    winner = false
    board.each do |row|
      winning_row_o = row.all? { |square| square === "o"}
      winning_row_x = row.all? { |square| square === "x"}

      winner = true if winning_row_o || winning_row_x 
    end
    winner
  end

  def winning_column?
    winner = false
    column_1 = [board[0][0], board[1][0], board[2][0]]
    column_2 = [board[0][1], board[1][1], board[2][1]]
    column_3 = [board[0][2], board[1][2], board[2][2]]
    columns = [column_1, column_2, column_3]
    columns.each do |col|
      winning_col_o = col.all? { |square| square === "o"}
      winning_col_x = col.all? { |square| square === "x"}

      winner = true if winning_row_o || winning_row_x 
    end

    winner
  end

  def winning_diagonal?
    winner = false
    diagonal_1 = [board[0][0], board[1][1], board[2][2]]
    diagonal_2 = [board[0][2], board[1][1], board[2][0]]
    diagonals = [diagonal_1, diagonal_2]
    
    diagonals.each do |diagonal|
      winning_diagonal_o = diagonal.all? { |square| square === "o"}
      winning_diagonal_x = diagonal.all? { |square| square === "x"}

      winner = true if winning_diagonal_o || winning_diagonal_x 
    end

    winner
  end
end

board = Board.new

board.show
puts "Where do you want to place your mark. Enter in [row,column] format. E.g. [1,2] means first row, second column."
position = gets.chomp
puts "putting your mark at #{position}"

# until board.winner?

# end

# create board
# ask player 1 for input
  # ask to input in (row, column) format
# check if spot is still available  
# place input on board if available and show board with input
  # otherwise ask for input again
# check if we have a winner
  # if we have a winner, display message
# if not, ask player 2 for input
# repeat all steps above
# repeat until we have a winner
  # congratulate winner