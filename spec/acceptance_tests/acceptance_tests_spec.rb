require_relative '../../tic_tac_toe.rb'

describe "Game initiation" do
    context "player starts game" do
        it "displays an empty board" do
            game = TicTacToe.new
            grid = "_|_|_\n_|_|_\n_|_|_\n"
            expect {game.show_board}.to output(grid).to_stdout
        end
    end
end
