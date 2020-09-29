require_relative 'game_controller'
require_relative 'board'
require_relative 'tic_tac_toe'
require_relative 'computer'

board = Board.new

computer = Computer.new

game_controller = GameController.new(board, computer)

tic_tac_toe = TicTacToe.new(game_controller)


game_over = tic_tac_toe.game_over

while game_over == false
    tic_tac_toe.show_board
    tic_tac_toe.player_move
    tic_tac_toe.computer_move

    game_over = tic_tac_toe.game_over
end