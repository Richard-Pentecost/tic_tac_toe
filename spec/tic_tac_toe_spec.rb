require_relative "../tic_tac_toe.rb"

describe TicTacToe do
    before(:each) do
        game_controller = { get_boardstate: "_|_|_\n_|_|_\n_|_|_\n" }
        @game = described_class.new(game_controller)
    end

    context "TicTacToe initialization" do
        it "initializes a game controller" do
            expect(@game.controller).to eq({ get_boardstate: "_|_|_\n_|_|_\n_|_|_\n" })
        end
    end

    context "show_board" do
        it "shows the current board" do
            grid = "_|_|_\n_|_|_\n_|_|_\n"
            expect {@game.show_board}.to output(grid).to_stdout
        end
    end

    context "get_input" do
        it "asks the user for a move" do
            value = allow(@game).to receive(:gets).and_return('hello')
            expect { @game.get_input }.to output("Please enter a valid move: \n").to_stdout
        end

        it "recieves user input" do
            value = allow(@game).to receive(:gets).and_return('hello')
            expect(@game.get_input).to eq('hello')
        end

        it "sets game over to true if the user inputs quit" do
            value = allow(@game).to receive(:gets).and_return('quit')
            @game.get_input
            expect(@game.game_over).to eq(true)
        end
    end

    context "player_move" do
        let(:game_controller) { spy("game_controller") }
        it "passed the player input to the game controller move method" do
            game = described_class.new(game_controller)
            allow(game).to receive(:gets).and_return('A1')
            game.player_move
            expect(game.controller).to have_received(:move).with(0,0)            
        end
    end
end




