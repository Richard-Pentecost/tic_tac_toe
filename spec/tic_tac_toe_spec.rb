require_relative "../tic_tac_toe.rb"
require_relative "../game_controller"

describe TicTacToe do
    context "TicTacToe initialization" do
        it "creates a game controller" do
            game = TicTacToe.new
            expect(game.controller.class).to be(GameController)
        end
    end

    context "show_board" do
        it "shows the current board" do
            game = described_class.new
            grid = "_|_|_\n_|_|_\n_|_|_\n"
            expect {game.show_board}.to output(grid).to_stdout
        end
    end

    context "get_input" do
        it "asks the user for a move" do
            game = TicTacToe.new
            value = allow(game).to receive(:gets).and_return('hello')
            expect { game.get_input }.to output("Please enter a valid move: \n").to_stdout
        end

        it "recieves user input" do
            game = TicTacToe.new
            value = allow(game).to receive(:gets).and_return('hello')
            expect(game.get_input).to eq('hello')
        end
    end
end




