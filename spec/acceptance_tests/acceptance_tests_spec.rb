require_relative '../../tic_tac_toe.rb'

describe "Game initiation" do
    let(:game_controller) {double('game controller')}
    before(:each) do
        @game = TicTacToe.new(game_controller)
    end
    # let(:gc) {double('game controller')}

    # it "shows the empty board" do
    #     allow(gc).to receive(:get_boardstate).and_return([['_','_','_'],['_','_','_'],['_','_','_']])
    #     game = described_class.new(gc)
    #     grid = "_|_|_\n_|_|_\n_|_|_\n"
    #     expect {@game.show_board}.to output(grid).to_stdout
    # end
    context "player starts game" do
        it "displays an empty board" do
            grid = "_|_|_\n_|_|_\n_|_|_\n"
            allow(game_controller).to receive(:get_boardstate).and_return([['_','_','_'],['_','_','_'],['_','_','_']])
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

    context "player makes a move" do
        xit "updates the board and shows it" do
            value = allow(@game).to receive(:gets).and_return('A1')
            @game.get_input
            grid = "X|_|_\n_|_|_\n_|_|_\n"
            expect {@game.show_board}.to output(grid).to_stdout
        end
    end
end

