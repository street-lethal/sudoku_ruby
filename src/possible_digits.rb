class PossibleDigits
  def initialize(possible_digits)
    @possible_digits = possible_digits
  end

  def multiple(other)
    product = {}

    (1..9).each do |i|
      next unless @possible_digits[i] && other[i]

      product[i] = true
    end

    PossibleDigits.new(product)
  end

  def [](digit)
    @possible_digits[digit]
  end

  def add(i)
    @possible_digits[i] = true
  end

  def remove(i)
    @possible_digits[i] = false
  end

  def to_s
    array = @possible_digits.map do |digit, possible|
      next unless possible

      digit.to_s
    end.compact

    "[#{array.join(',')}]"
  end
end
