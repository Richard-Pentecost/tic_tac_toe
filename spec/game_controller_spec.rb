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

    context "cell_empty?" do
        let(:board) { spy("board") }
        it "returns true if cell is empty" do
            computer = 'computer'
            allow(board).to receive(:board).and_return([['_','_','_'],['_','_','_'],['_','_','_']])
            game_controller = GameController.new(board, computer)
            expect(game_controller.cell_empty?(0,0)).to eq(true)
        end
        it "returns false if cell is full" do
            computer = 'computer'
            allow(board).to receive(:board).and_return([['X','_','_'],['_','_','_'],['_','_','_']])
            game_controller = GameController.new(board, computer)
            expect(game_controller.cell_empty?(0,0)).to eq(false)
        end
    end

    context "run_ai" do
        let(:computer) { spy("computer") }
        let(:board) { spy("board") }
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

    context "get_game_status" do
        let(:board) {double("board")}
        it "returns pending if the board is not won or drawn" do
            allow(board).to receive(:board).and_return([['_','_','_'],['_','_','_'],['_','_','_']])
            computer = "computer"
            game_controller =  described_class.new(board, computer)
            expect(game_controller.get_game_status).to eq("pending")
        end

        it "returns drawn if the board is a draw" do
            allow(board).to receive(:board).and_return([['O','X','O'],['X','X','O'],['X','O','X']])
            computer = "computer"
            game_controller =  described_class.new(board, computer)
            expect(game_controller.get_game_status).to eq("drawn")
        end
    end

    context "three_in_a_row?" do
        before(:each) do
            computer = 'computer'
            board = 'board'
            @game_controller = described_class.new(board, computer)
        end
        it "returns false, if there aren't 3 X's in a row and checking for X" do
            current_board = [['_','_','_'],['_','_','_'],['_','_','_']]
            expect(@game_controller.three_in_a_row?(current_board, "X")).to eq(false)
        end
        
        it "returns true, if top row has all X's and checking for X" do
            current_board = [['X','X','X'],['_','_','_'],['_','_','_']]
            expect(@game_controller.three_in_a_row?(current_board, "X")).to eq(true)
        end

        xit "returns true, if top row has all X's and checking for X" do
            current_board = [['_','_','_'],['X','X','X'],['_','_','_']]
            expect(@game_controller.three_in_a_row?(current_board, "X")).to eq(true)
        end


    end
end
