class Board < Array
  attr_reader :ships_at, :hits_at
  
    def initialize(array) # expect a 2D array
      @ships_at = []
      @hits_at = []
      super
    end

    def coordinate_range(start_index, end_index)
    if start_index[0] == end_index[0]    # Horizontal placement
      (start_index..end_index).map do |coordinate|
        coordinate.to_s
      end

   elsif start_index[1] == end_index[1]  # Vertical placement
     (start_index[0]..end_index[0]).map do |coordinate|
       coordinate + end_index[1].to_s
     end
   else
     puts "Ships need to be placed either vertically or horizontally"
   end
 end


 def hide_ships
   flat = self.flatten.map do |cell|
     cell.sub(SYMBOLS[:ship], SYMBOLS[:empty])
   end
   flat.each_slice(10).to_a
 end



 def place_ship!(ship, start_index, end_index)
  unless valid_placement?(ship, start_index, end_index)
    puts "Invalid placement"
    return nil
  end
  
  coordinate_range(start_index, end_index).each do |coordinate|
    index_lookup(coordinate).sub!(SYMBOLS[:empty], SYMBOLS[:ship])
  end
  
  @ships_at << coordinate_range(start_index, end_index)
  
end

def replace_sunken_ships
  @ships_at.each do |ship_coordinates|
    if (ship_coordinates - @hits_at).empty?
      ship_coordinates.each do |index|
       index_lookup(index).sub!(SYMBOLS[:hit], SYMBOLS[:sunk])
     end
   end
 end
 return self
end

def fire!(index)
  cell = index_lookup(index)
  if cell == SYMBOLS[:empty]
    cell.sub!(SYMBOLS[:empty], SYMBOLS[:miss])
  elsif cell == SYMBOLS[:ship]
    cell.sub!(SYMBOLS[:ship], SYMBOLS[:hit])
  end
  @hits_at << index

end

def index_lookup(str)
  self[ROWS[str[0]]][str[1].to_i] rescue nil
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


def valid_placement?(ship, start_index, end_index)
  coordinate_range(start_index, end_index).each do |cell|
    return false if index_lookup(cell) == SYMBOLS[:ship]
  end
  coordinate_range(start_index, end_index).length == SHIPS[ship]

end
end


