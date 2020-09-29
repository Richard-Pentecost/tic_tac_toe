require_relative '../../tic_tac_toe.rb'
require_relative '../../board.rb'
require_relative '../../game_controller.rb'
require_relative '../../computer.rb'

describe "Game initiation" do
    before(:each) do
        board = Board.new
        computer = Computer.new
        game_controller = GameController.new(board, computer)
        @game = TicTacToe.new(game_controller)
    end

    context "player starts game" do
        it "displays an empty board" do
            grid = "_|_|_\n_|_|_\n_|_|_\n"
            expect {@game.show_board}.to output(grid).to_stdout
        end
    end

    context "players starts a game but decides to end game" do
        it "sets the game_over flag to true" do
            allow(@game).to receive(:gets).and_return('quit')
            @game.get_input
            expect(@game.game_over).to eq(true)
        end
    end

    context "player makes a move" do
        it "updates the board and shows it" do
            allow(@game).to receive(:gets).and_return('A1')
            @game.player_move
            grid = "X|_|_\n_|_|_\n_|_|_\n"
            expect {@game.show_board}.to output(grid).to_stdout
        end
    end

    context "computer makes a move" do
        it "updates a board and shows it" do
            allow(@game).to receive(:gets).and_return('A1')
            @game.player_move
            @game.computer_move
            grid = "X|O|_\n_|_|_\n_|_|_\n"
            expect {@game.show_board}.to output(grid).to_stdout
        end
    end
end

