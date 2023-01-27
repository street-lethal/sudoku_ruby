class Tile
  attr_accessor :digit, :default, :row, :col, :square

  def blank?
    digit == 0
  end

  def set(digit)
    self.digit = digit
  end

  def clear
    self.digit = 0
  end

  def to_s
    return ' ' if blank?

    digit.to_s
  end
end
