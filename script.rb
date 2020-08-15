class TicTacToe
  def initialize
    @board = Board.new
    @player_1 = Player.new('Player 1', 'X', @board)
    @player_2 = Player.new('Player 2', 'O', @board)
    @current_player = @player_1
  end

  def play
    loop do 
      @board.render
      @current_player.play_round
      
      if game_over?
        @board.render

        if @board.winner?(@current_player) 
          puts "Congrats, #{@current_player.name}. You won!"
        else
          puts "It\'s a draw!"
        end

        break
      end

      switch_current_player
    end
  end

  def game_over?
    @board.winner?(@current_player) || @board.draw?
  end

  def switch_current_player
    @current_player = @current_player === @player_1 ? @player_2 : @player_1
  end
end

class Board
  def initialize
    @board = [
      [nil, nil, nil], 
      [nil, nil, nil], 
      [nil, nil, nil]
    ]
  end

  def render 
    @board.each_with_index do |row, row_index|
      row_to_display = ''
    
      row.each_with_index do |square, square_index|
        str = (square || ' ')
        if (square_index != row.length - 1)
          str += ' | '
        end
        row_to_display += str
      end
    
      puts row_to_display
      puts "---------" if row_index != @board.length - 1
    end
  end

  def add_token(coords, piece)
    @board[coords[0]][coords[1]] = piece
  end

  def winner?(current_player)
    vertical_winner?(current_player) ||
    horizontal_winner?(current_player) ||
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

    columns.any? do |column|
      column.all? {|square| square == current_player.token}
    end
  end

  def horizontal_winner?(current_player)
    @board.any? do |row|
      row.all? {|square| square == current_player.token}
    end
  end

  def diagonal_winner?(current_player)
    diagonal_1 = [@board[0][0], @board[1][1], @board[2][2]]
    diagonal_2 = [@board[2][0], @board[1][1], @board[0][2]]
    diagonals = [diagonal_1, diagonal_2]

    diagonals.any? do |diagonal|
      diagonal.all? {|diagonal| diagonal == current_player.token}
    end
  end

  def position_available(coords)
    @board[coords[0]][coords[1]] == nil
  end
end

class Player
  attr_accessor :token

  def initialize(name, token, board)
    @name = name
    @token = token
    @board = board
  end

  def play_round
    loop do 
      coords = get_coordinates

      if validate_coords(coords) 
        position_available = @board.position_available(coords)
        if position_available 
          @board.add_token(coords, @token)
          break
        else
          puts "That position has already been taken. Add different coordinates."
        end
      end
    end
  end

  def get_coordinates
    puts "#{@name} (#{@token}), enter your coordinates in row,column format (e.g 1,1): "
    gets.strip.split(",").map{|coord| coord.to_i - 1}
  end

  def validate_coords(coords)
    proper_format(coords) &&
    within_boundaries(coords)
  end

  def proper_format(coords)
    if coords.is_a?(Array) && coords.size == 2
      true
    else
      puts "Your coordinates are not in the correct format."
    end
  end

  def within_boundaries(coords)
    if coords.all?{|coord| [0, 1, 2].include?(coord)}
      true
    else
      puts "Your coordinates must be both within the 1-3 range."
    end
  end
end

game = TicTacToe.new
game.play