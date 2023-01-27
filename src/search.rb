require_relative 'walker'

def search(board)
  tiles = []
  board.blank_ids.each do |blank_id|
    tiles << board.tiles[blank_id]
  end

  walker = Walker.new(tiles)
  loop do
    tile = walker.current_tile
    break unless tile

    if walker.stepped_back
      walker.stored_possible_digits.remove(tile.digit)
      tile.clear
    else
      walker.store_possible_digits(board.possible_digits(tile))
    end

    walker.set_one_possible_digit

    next walker.step_back if tile.blank?

    walker.step_forward
  end
end
