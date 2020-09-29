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

        it "instructs board to add a move with alternate symbols" do
            computer = 'computer'
            game_controller = GameController.new(board, computer)
            game_controller.move(0,1)
            game_controller.move(0,0)
            expect(game_controller.board).to have_received(:add_move).with(0, 0, "O")
        end
    end

    context "run_ai" do
        let(:computer) { spy("computer") }
        let(:board) {spy("board")}
        it "calls the move method in the computer class" do
            game_controller =  described_class.new(board, computer)
            allow(game_controller.computer).to receive(:move).and_return([0,0])
            allow(game_controller).to receive(:move).and_return(nil)
            game_controller.run_ai
            expect(game_controller.computer).to have_received(:move).with(board)
        end

        it "calls the game controller move with new coordinates" do
            game_controller =  described_class.new(board, computer)
            allow(game_controller.computer).to receive(:move).and_return([0,0])
            allow(game_controller).to receive(:move).and_return(nil)
            game_controller.run_ai
            expect(game_controller).to have_received(:move).with(0,0)
        end

        it "calls the game controller move with different coordinates" do
            game_controller =  described_class.new(board, computer)
            allow(game_controller.computer).to receive(:move).and_return([1,0])
            allow(game_controller).to receive(:move).and_return(nil)
            game_controller.run_ai
            expect(game_controller).to have_received(:move).with(1,0)
        end
    end
end