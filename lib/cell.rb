class Cell
  attr_accessor :content

  alias_method :ship, :content
  alias_method :ship=, :content=

  Sunken = "\u2620"
  Hit = "\u2694"
  Miss = "\u26AB"
  Empty = "\u223C"
  Ship = "\u26F5"

  
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

  def hit?
    @content == Hit
  end
  
  def miss!
    @content = Miss
  end

  def mark_ship!
    # raise "Cell is not empty" unless empty?
    
    @content = Ship
  end

  def ship?
    @content == Ship
  end

  def sink!
    @content = Sunken
  end

  def sunken?
    @content == Sunken
  end

  def hide_ship
    return Empty if ship?
  end

  def to_s
    @content
  end
end

