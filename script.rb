# Set up the game (TicTacToe)
#   Create a game board (Board)
#   Create two players (Players)
# Start loop (TicTacToe)
#   Render the game board (Board)
#   Ask for input from player 1 (Player)
#     Until input is given and valid (Player)
#   Put player's token on the board (Board)
#     Check if spot is available (Board)
#     Otherwise display error and ask for input again 
#     Check if they won (TicTacToe)
#       If they won
#         Display message 
#         Stop the loop
#       Else
#         Switch players (TicTacToe)

class TicTacToe
  def initialize
    @board = Board.new
    @player_1 = Player.new('Player 1', 'X')
    @player_2 = Player.new('Player 2', 'O')
    @current_player = @player_1
  end

  def play
    loop do 
      token_added = false
      loop do
        coords = ask_coordinates
        valid_coords = validate_coords(coords)
        if valid_coords do 
          position_available = @board.check_position(coords)
          if position_available do 
            @board.add_token
            token_added = true
          else
            puts "That position has already been taken. Add different coordinates."
          end
        else
          puts "Invalid input. Please enter the coordinates in the [x,y] format."
        end

        break if token_added
      end

      switch_current_player
      break if game_over?
    end
  end

  def game_over?
    @board.winner?(@current_player) || @board.draw?
  end

  # initialize
    # board
    # players
    # current_player
    # winner?(current_player)
      # vertical
      # diagonal
      # horizontal

  # play
    # loop
    # render board
    # ask_input(current_player) or player.ask_input
      # check validity
        # format
        # board spot is free?
        # if valid and free => board.place_token
          # winner?
            # if yes display message and stop loop
            # else switch players
        # else ask input again

  # switch_current_player
end

class Board
  # initialize
  # render
  # place_token
  # spot = free
  def initialize
    @board = [
      [nil, nil, nil], 
      [nil, nil, nil], 
      [nil, nil, nil]
    ]
  end

  def render 
    @board.each_with_index do |row, row_index|
      to_display = ''
    
      row.each_with_index do |square, square_index|
        str = (square || ' ')
        if (square_index != row.length - 1)
          str += ' | '
        end
        to_display += str
      end
    
      puts to_display
      puts "---------" if row_index != board.length - 1
    end
  end

  def winner?(current_player)
    vertical_winner?(current_player)
    horizontal_winner?(current_player)
    diagonal_winner?(current_player)
  end

  def draw?
    @board.all? do |row|
      row.none? {|square| square.nil?}
    end
  end

  def vertical_winner?(current_player)
    column_1 = [@board[0][0], @board[1][0], @board[2][0]]
    column_2 = [@board[0][1], @board[1][1], @board[2][1]]
    column_3 = [@board[0][2], @board[1][2], @board[2][2]]
    columns = [column_1, column_2, column_3]

    columns.each do |column|
      column.each {|square| square == current_player.token}
    end
  end

  def horizontal_winner?(current_player)
    @board.each do |row|
      row.each {|square| square == current_player.token}
    end
  end

  def diagonal_winner?(current_player)
    diagonal_1 = [@board[0][0], @board[1][1], @board[2][2]]
    diagonal_2 = [@board[2][0], @board[1][1], @board[0][2]]
    diagonals = [diagonal_1, diagonal_2]

    diagonals.each do |diagonal|
      diagonal.each {|diagonal| diagonal == current_player.token}
    end
  end
end

class Player
  # initialize
  # check input format validity
  def initialize(name, token)
    @name = name
    @token = token
  end
end

game = TicTacToe.new
game.start