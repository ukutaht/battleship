class Cell
  attr_accessor :content

  alias_method :ship, :content
  alias_method :ship=, :content=
  
  def initialize(content=Empty)
    @content = content
  end

  def empty?
    @content == Empty
  end

  def empty!
    @content = Empty
  end

  def hit!
    @content = Hit
  end
  
  def miss!
    @content = Miss
  end

  def place_ship!
    raise "Not allowed" unless empty?
    
    @content = Ship
  end

  def ship?
    @content == Ship
  end

  def sink!
    @content = Sunk
  end

  def hide_ship
    return Empty if ship?
  end

  def to_s
    @content
  end
end

