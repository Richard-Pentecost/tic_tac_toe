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
        let(:board_checker) {double("board_checker")}
        it "returns pending if the board is not won or drawn" do
            current_board = [['_','_','_'],['_','_','_'],['_','_','_']]
            allow(board).to receive(:board).and_return(current_board)
            allow(board_checker).to receive(:three_in_a_line?).with(current_board,"X").and_return(false)
            allow(board_checker).to receive(:three_in_a_line?).with(current_board,"O").and_return(false)
            allow(board_checker).to receive(:full_board?).and_return(false)
            computer = "computer"
            game_controller =  described_class.new(board, computer)
            game_controller.add_board_checker(board_checker)
            expect(game_controller.get_game_status).to eq("pending")
        end

        it "returns drawn if the board is a draw" do
            current_board = [['O','X','O'],['X','X','O'],['X','O','X']]
            allow(board).to receive(:board).and_return(current_board)
            allow(board_checker).to receive(:three_in_a_line?).with(current_board,"X").and_return(false)
            allow(board_checker).to receive(:three_in_a_line?).with(current_board,"O").and_return(false)
            allow(board_checker).to receive(:full_board?).and_return(true)
            computer = "computer"
            game_controller =  described_class.new(board, computer)
            game_controller.add_board_checker(board_checker)
            expect(game_controller.get_game_status).to eq("drawn")
        end

        it "returns X win if the board is won by X" do
            current_board = [['X','_','O'],['X','X','O'],['X','O','X']]
            allow(board).to receive(:board).and_return(current_board)
            allow(board_checker).to receive(:three_in_a_line?).with(current_board,"X").and_return(true)
            computer = "computer"
            game_controller =  described_class.new(board, computer)
            game_controller.add_board_checker(board_checker)
            expect(game_controller.get_game_status).to eq("X win")
        end

        it "returns O win if the board is won by O" do
            current_board = [['X','O','O'],['X','O','X'],['O','O','X']]
            allow(board).to receive(:board).and_return(current_board)
            allow(board_checker).to receive(:three_in_a_line?).with(current_board,"X").and_return(false)
            allow(board_checker).to receive(:three_in_a_line?).with(current_board,"O").and_return(true)
            computer = "computer"
            game_controller =  described_class.new(board, computer)
            game_controller.add_board_checker(board_checker)
            expect(game_controller.get_game_status).to eq("O win")
        end
    end
end
