class Game 
  attr_accessor :board, :player_1, :player_2
  
  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
  ]
  
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end 
  
  def current_player 
    @board.turn_count % 2 == 0? player_1 : player_2   #If the turn count has a remainder of 0 then it's player_1 turn
  end 
  
  def won?
        WIN_COMBINATIONS.each do |combination|   #[0,1,2] which is board range (0-8)
        if @board.cells[combination[0]] == @board.cells[combination[1]] &&
          @board.cells[combination[1]] == @board.cells[combination[2]] &&
          @board.taken?(combination[0]+1)
          #Need to +1, because #taken? rspec test is working off user_input range (1-9)
          return combination
        end
      end
    return false
  end
  
  def draw? 
    if !won? && @board.full?
      return true 
    else 
      return false
    end 
  end 
   
   def over? 
     if won? || @board.full? || draw?  #won? and draw? methods are in this class but full? isn't 
       return true                     #which is why we needed to add the @board in front of it
     else 
       return false
     end 
   end 
   
   def winner
     if won?
       combination = won?
       @board.cells[combination[0]]
     end 
   end 
   
   def turn
    puts "Please enter 1-9:"
    @user_input = current_player.move(@board)
    if @board.valid_move?(@user_input)
      @board.update(@user_input, current_player)
    else puts "Please enter a number 1-9:"
      @board.display
      turn
    end
    @board.display
  end

  def play 
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end 