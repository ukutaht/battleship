class ComputerPlayer 
  attr_accessor :fleet, :salvo, :board

  def initialize
    @fleet = [ Ship.new('Aircraft carrier', 5),
               Ship.new('Battleship', 4),
               Ship.new('Cruiser', 3),
               Ship.new('Destroyer', 2),
               Ship.new('Destroyer', 2),
               Ship.new('Submarine', 1),
               Ship.new('Submarine', 1)]
    @board = Board.new
    @valid_moves = Board.extract_all_indices
  end


  def show_board
    @board.replace_sunken_ships.hide_ships.flatten
  end

  def all_ships_sunk?
    @board.all_ships_sunk?
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
