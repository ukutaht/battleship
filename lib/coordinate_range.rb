class CoordinateRange
  def initialize(start_index, end_index)
    @start_index = start_index
    @end_index = end_index
  end

  def self.get(start_index, end_index)
    new(start_index, end_index).get
  end

  def get
    raise "Invalid range" unless valid?

    if horizontal_placement?
      iterate_columns
    elsif vertical_placement?
      iterate_rows
    end
  end

  def valid?
    horizontal_placement? || vertical_placement?
  end

  private

  def horizontal_placement?
    @start_index[0] == @end_index[0]
  end

  def vertical_placement?
    @start_index[1] == @end_index[1]
  end

  def iterate_columns
    (@start_index..@end_index).map do |coordinate|
      coordinate.to_s
    end
  end

  def iterate_rows
    (@start_index[0]..@end_index[0]).map do |coordinate|
      coordinate + @end_index[1].to_s
    end

  end

end
