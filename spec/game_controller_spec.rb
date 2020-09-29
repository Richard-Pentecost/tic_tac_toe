require_relative "../game_controller.rb"

describe GameController do
    context "initialize GameController" do
        computer = 'computer'
        board = 'board'
        game_controller = described_class.new(board, computer)
        it "initializes a new board" do
            expect(game_controller.board).to eq('board')
        end

        it "initializes a computer player" do
            expect(game_controller.computer).to eq('computer')
        end
    end

    context "move" do
        let(:board) { spy("board") }
        it "instructs board to add a move" do
            computer = 'computer'
            game_controller = GameController.new(board, computer)
            game_controller.move(0,1)
            expect(game_controller.board).to have_received(:add_move).with(0, 1, "X")
        end
    end
end