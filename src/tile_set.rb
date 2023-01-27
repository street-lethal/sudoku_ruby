require_relative 'possible_digits'

class TileSet
  def initialize(tiles)
    @tiles = tiles
  end

  def <<(tile)
    @tiles << tile
  end

  def [](index)
    @tiles[index]
  end

  def filled?
    @tiles.each do |tile|
      return false if tile.blank?
    end

    true
  end

  def duplicates?
    duplicate = {}

    @tiles.each do |tile|
      next if tile.blank?

      return true if duplicate[tile.digit]

      duplicate[tile.digit] = true
    end

    false
  end

  def possible_digits
    possible = {
      1 => true, 2 => true, 3 => true, 4 => true, 5 => true,
      6 => true, 7 => true, 8 => true, 9 => true
    }

    @tiles.each do |tile|
      next if tile.blank?

      possible[tile.digit] = false
    end

    PossibleDigits.new(possible)
  end
end
