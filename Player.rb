require 'pry'

class Player
  attr_accessor :fleet, :salvo, :board
  
  def initialize 
    @fleet = STANDARD_FLEET
    @salvo = STANDARD_FLEET
    @board = Board.new(PLAYER_BOARD)
  end


  def place_ship!(ship, start_index, end_index)
    unless @fleet[ship] == 0
      @board.place_ship!(ship, start_index, end_index)
      @fleet[ship] -= 1
    else
      puts "What are you doing? You're out of #{ship}s."
    end
  end

  def show_board   
    @board.replace_sunken_ships.flatten
  end

  def ships_placed?
    @fleet.values.inject(:+) == 0
  end


end

class ComputerPlayer 
  attr_accessor :fleet, :salvo, :board

  def initialize
    @fleet = STANDARD_FLEET
    @salvo = STANDARD_FLEET
    @board = Board.new(COMPUTER_BOARD)
    @valid_moves = Board.extract_all_indices
  end


  def show_board   
    @board.replace_sunken_ships.hide_ships.flatten
  end

  def show_hits
    @board.hits_at
  end

  def place_all_ships
    @board.place_ship!('Aircraft carrier','F2','F6')
    @board.place_ship!('Cruiser','A1','A3')
    @board.place_ship!('Battleship','C8','F8')
    @board.place_ship!('Submarine','I0','I0')
    @board.place_ship!('Destroyer','H8','I8')
    @board.place_ship!('Submarine','D0','D0')
  end


  def fire_randomly
    random = @valid_moves.sample
    @valid_moves.delete(random)
  end
  
  #TODO: random AI
end
