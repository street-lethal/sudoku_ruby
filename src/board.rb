require_relative 'tile'
require_relative 'tile_set'

class Board
  attr_accessor :tiles, :blank_ids

  class << self
    def load_from_file(file_name)
      tiles = []
      File.open(file_name, 'r') do |f|
        until f.eof?
          record = f.readline
          record.split('').each do |digit|
            next if digit =~ /\R/

            tile = Tile.new
            tile.digit = digit.to_i
            tiles << tile
          end
        end
      end

      new.tap do |board|
        board.tiles = tiles
      end
    end
  end

  def init
    @rows = {}
    @cols = {}
    @squares = {}
    @blank_ids = []
    (0...81).each do |i|
      row, col = i.divmod(9)
      square = (row / 3) * 3 + col / 3

      tile = @tiles[i]
      @rows[row] ||= TileSet.new([])
      @rows[row] << tile
      @cols[col] ||= TileSet.new([])
      @cols[col] << tile
      @squares[square] ||= TileSet.new([])
      @squares[square] << tile
      if tile.blank?
        @blank_ids << i
      else
        tile.default = true
      end
      tile.row = row
      tile.col = col
      tile.square = square
    end
  end

  def to_s
    bar = "+-------+-------+-------+\n"
    display = bar.dup
    (0...9).each do |row|
      row_display = [
        "#{@rows[row][0]} #{@rows[row][1]} #{@rows[row][2]}",
        "#{@rows[row][3]} #{@rows[row][4]} #{@rows[row][5]}",
        "#{@rows[row][6]} #{@rows[row][7]} #{@rows[row][8]}"
      ].join(' | ')
      display << "| #{row_display} |\n"
      display << bar if row % 3 == 2
    end

    display
  end

  def validate
    (0...9).each do |row|
      return "Row #{row} is not filled" unless @rows[row].filled?
      return "Row #{row} duplicates" if @rows[row].duplicates?
    end

    (0...9).each do |col|
      return "col #{col} is not filled" unless @cols[col].filled?
      return "col #{col} duplicates" if @cols[col].duplicates?
    end

    (0...9).each do |square|
      return "square #{square} is not filled" unless @squares[square].filled?
      return "square #{square} duplicates" if @squares[square].duplicates?
    end

    nil
  end

  def possible_digits(tile)
    digits_row = @rows[tile.row].possible_digits
    digits_col = @cols[tile.col].possible_digits
    digits_square = @squares[tile.square].possible_digits

    digits_row.multiple(digits_col).multiple(digits_square)
  end
end
