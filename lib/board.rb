class Board < Array
  attr_reader :ships, :hits_at
  
  def initialize
    array = Array.new(10) { Array.new(10, Cell.new) }
    @ships = []
    @hits_at = []
    super(array)
  end


  def place_ship!(ship, coordinates)
    raise "Invalid placement" unless valid_placement?(ship, coordinates)
    
    ship.place(coordinates)    
    
    @ships << ship
    coordinates.each do |coordinate|
      cell_at(coordinate).mark_ship!
    end
  
  end


  def fire!(index)
    cell = cell_at(index)
    if cell.empty?
      cell.miss!
    elsif cell.ship?
      cell.hit!
    end

    @hits_at << index
  end


  def hide_ships
   self.each do |row|
     row.each do |cell|
       cell.hide_ship
     end
   end
  end


  def replace_sunken_ships
    @ships.each do |ship|
      if (ship.coordinates - @hits_at).empty?
        ship.coordinates.each do |index|
          cell_at(index).sink!
        end
      end
    end

    return self
  end

  def self.extract_all_indices
    indicies = []
    letters = ("A".."J").to_a
    numbers = (0..9).to_a.map{|n| n.to_s}
    letters.each do |letter|
      numbers.each do |num|
        indicies.push(letter+num)
      end
    end
    indicies
  end

  def cell_at(index)
    self[ROWS[index[0]]][index[1].to_i] rescue nil
  end

  private


  def valid_placement?(ship, coordinates)
    coordinates.each do |index|
      raise "There's already a ship at index #{index}" if cell_at(index).ship?
    end
  end

end




