require_relative 'game_controller'
require_relative 'board'
require_relative 'tic_tac_toe'


board = Board.new

game_controller = GameController.new(board)

tic_tac_toe = TicTacToe.new(game_controller)


game_over = false

while game_over == false
    tic_tac_toe.show_board
    tic_tac_toe.get_input
    game_over = true
end