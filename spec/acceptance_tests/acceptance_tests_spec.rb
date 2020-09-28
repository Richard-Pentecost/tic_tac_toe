require_relative '../../tic_tac_toe.rb'

describe "Game initiation" do
    before(:each) do
        game_controller = 'game controller'
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
            value = allow(@game).to receive(:gets).and_return('quit')
            @game.get_input
            expect(@game.game_over).to eq(true)
        end
    end

end

