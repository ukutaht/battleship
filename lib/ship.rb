class Ship

  attr_reader :name, :length
  attr_accessor :coordinates

  def initialize(name, length)
    @name = name
    @length = length
    @coordinates = []
  end

  def placed?
    coordinates.empty?
  end

  def place(coordinates)
    raise "Invalid placement, expected coordinates of length #{length}, got #{coordinates.length}" unless coordinates.length == length
    @coordinates = coordinates
  end

end
