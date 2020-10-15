require_relative 'lib/game_controller'
require_relative 'lib/board'
require_relative 'lib/tic_tac_toe'
require_relative 'lib/computer'
require_relative 'lib/board_checker'

board = Board.new

computer = Computer.new

game_controller = GameController.new(board, computer)
game_controller.add_board_checker(BoardChecker.new)

tic_tac_toe = TicTacToe.new(game_controller)


game_over = tic_tac_toe.game_over
tic_tac_toe.introduce_game

while game_over == false
    tic_tac_toe.show_board
    tic_tac_toe.player_move
    tic_tac_toe.end_game_if_over
    break if tic_tac_toe.game_over

    tic_tac_toe.computer_move
    tic_tac_toe.end_game_if_over
    game_over = tic_tac_toe.game_over
end
tic_tac_toe.show_board