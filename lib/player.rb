class Player
  attr_reader :fleet, :board
  
  def initialize 
    @fleet = [ Ship.new('Aircraft carrier', 5),
               Ship.new('Battleship', 4),
               Ship.new('Cruiser', 3),
               Ship.new('Destroyer', 2),
               Ship.new('Destroyer', 2),
               Ship.new('Submarine', 1),
               Ship.new('Submarine', 1)]

    @board = Board.new
  end

  def all_ships_sunk?
    @board.all_ships_sunk?
  end


  def place_ship(ship, coordinates)
    ship.place(coordinates)
    board.mark_ship!(ship.coordinates)
  end

  def show_board
    @board.replace_sunken_ships.flatten
  end

  def ships_placed?
    @fleet.empty?
  end
end
