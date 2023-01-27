require_relative 'src/board'
require_relative 'src/search'

board = Board.load_from_file('./data/board.txt')
board.init
puts board

search(board)
puts board
