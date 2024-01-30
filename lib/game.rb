class Game
  def initialize
    @board = [
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
    ]
    @player1 = "O"
    @player2 = "X"
    @current = @player1
  end

  def ask_player
    loop do
      display_board
      display_player
      puts "choose a column between 0 and 6"
      column = gets.chomp.to_i
      return if column.downcase == "quit"
      break unless check_input(column)
    end
  end

  def display_board
    puts ""
    puts "  0   1   2   3   4   5   6"
    puts "+---+---+---+---+---+---+---+"

    @board.each do |row|
      puts "| #{row.map { |cell| cell.nil? ? " " : cell }.join(" | ")} |"
      puts "+---+---+---+---+---+---+---+"
    end
  end

  def display_player
    @current == @player1 ? (puts "it's your turn Player1!") : (puts "it's your turn Player2!")
  end

  def check_input(column)
    if (0..6).include?(column) && @board[0][column].nil?
      player_turn(@current, column)
    else
      puts "invalid"
      ask_player
    end
  end

  def player_turn(current_player, column)
    row = 5
    while row >= 0
      if @board[row][column].nil?
        @board[row][column] = current_player
        break
      end
      row -= 1
    end
    check_win
  end

  def switch_players
    if @current == @player1
      @current = @player2
    else
      @current = @player1
    end
  end

  def check_win
    if horizontal_win? then end_game elsif vertical_win? then end_game elsif diagonal_win? then end_game else
      switch_players
      ask_player
    end
  end

  def horizontal_win?
    @board.flatten.each_cons(4).any? { |values| values.all?(@current) }
  end

  def vertical_win?
    7.times do |col|
      temp = Array.new
      6.times do |row|
        temp.push(@board[row][col])
        return true if temp.each_cons(4).any? { |values| values.all?(@current) }
      end
    end
    false
  end

  def diagonal_win?
    rows = @board.size
    columns = @board[0].size
    (0..rows - 4).each do |row|
      (0..columns - 4).each do |col|
        tokens = (0..3).map { |i| @board[row + i][col + i] }
        return true if tokens.compact.length == 4 && tokens.uniq.length == 1
      end
    end

    (3..rows - 1).each do |row|
      (0..columns - 4).each do |col|
        tokens = (0..3).map { |i| @board[row - i][col + i] }
        return true if tokens.compact.length == 4 && tokens.uniq.length == 1
      end
    end
    false
  end

  def display_winner
    if @current == @player1
      puts "congrats, player1 has won the game!"
      display_board
    else
      puts "congrats, player2 has won the game!"
      display_board
    end
  end

  def end_game
    display_winner
    puts "do u wanna play another game? type yes or y and it will start"
    input = gets.chomp.downcase
    if input == "yes" || input == "y"
      setup
    else
      puts "ty for playing"
    end
  end

  def setup
    @board = [
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil],
    ]
    @player1 = "O"
    @player2 = "X"
    @current = @player1
    ask_player
  end
end

game = Game.new
game.ask_player
