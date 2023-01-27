class Walker
  attr_reader :stepped_back

  def initialize(tiles)
    @tiles = tiles
    @step = 0
    @len = @tiles.count
    @possible_digits = {}
    @stepped_back = false
  end

  def current_tile
    return if @step >= @len || @step < 0

    @tiles[@step]
  end

  def store_possible_digits(possible_digits)
    @possible_digits[@step] = possible_digits
  end

  def stored_possible_digits
    @possible_digits[@step]
  end

  def set_one_possible_digit
    (1..9).each do |digit|
      next unless stored_possible_digits[digit]

      current_tile.set(digit)
      return
    end
  end

  def step_forward
    @step += 1
    @stepped_back = false
  end

  def step_back
    @step -= 1
    @stepped_back = true
  end
end
