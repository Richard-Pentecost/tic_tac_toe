require_relative '../board_checker'

describe BoardChecker do

    context "three_in_a_line?" do

        let(:board_checker) { described_class.new }
        
        it "returns false, if there aren't 3 X's in a row and checking for X" do
            current_board = [['_','_','_'],['_','_','_'],['_','_','_']]
            expect(board_checker.three_in_a_line?(current_board, "X")).to eq(false)
        end
        
        it "returns true, if top row has all X's and checking for X" do
            current_board = [['X','X','X'],['_','_','_'],['_','_','_']]
            expect(board_checker.three_in_a_line?(current_board, "X")).to eq(true)
        end
    
        it "returns true, if top row has all X's and checking for X" do
            current_board = [['_','_','_'],['X','X','X'],['_','_','_']]
            expect(board_checker.three_in_a_line?(current_board, "X")).to eq(true)
        end
    
        it "returns true, if top row has all X's and checking for O" do
            current_board = [['O','O','O'],['_','_','_'],['_','_','_']]
            expect(board_checker.three_in_a_line?(current_board, "O")).to eq(true)
        end
    
        it "returns true, if first column has all X's and checking for X" do
            current_board = [['X','_','_'],['X','_','_'],['X','_','_']]
            expect(board_checker.three_in_a_line?(current_board, "X")).to eq(true)
        end
    
        it "returns true, if last column has all X's and checking for X" do
            current_board = [['_','_','X'],['_','_','X'],['_','_','X']]
            expect(board_checker.three_in_a_line?(current_board, "X")).to eq(true)
        end
    
        it "returns true, if middle column has all O's and checking for O" do
            current_board = [['_','O','_'],['_','O','_'],['_','O','_']]
            expect(board_checker.three_in_a_line?(current_board, "O")).to eq(true)
        end
    
        it "returns true, if diagonal has all X's and checking for X" do
            current_board = [['X','_','_'],['_','X','_'],['_','_','X']]
            expect(board_checker.three_in_a_line?(current_board, "X")).to eq(true)
        end
    
        it "returns true, if diagonal has all O's and checking for O" do
            current_board = [['O','_','_'],['_','O','_'],['_','_','O']]
            expect(board_checker.three_in_a_line?(current_board, "O")).to eq(true)
        end
    
        it "returns true, if diagonal has all X's and checking for X" do
            current_board = [['_','_','X'],['_','X','_'],['X','_','_']]
            expect(board_checker.three_in_a_line?(current_board, "X")).to eq(true)
        end
    
        it "returns true, if diagonal has all X's, with O's in the board and checking for X" do
            current_board = [['O','_','X'],['_','X','O'],['X','_','_']]
            expect(board_checker.three_in_a_line?(current_board, "X")).to eq(true)
        end

    end
  
    context 'drawn_board?' do
        let(:board_checker) { described_class.new }
        it "returns true, if the board is drawn" do
            current_board = [['X','O','O'],['X','O','X'],['O','O','X']]
            expect(board_checker.full_board?(current_board)).to eq(true)
        end
        it "returns true, if the board is drawn" do
            current_board = [['_','O','O'],['X','O','X'],['O','O','X']]
            expect(board_checker.full_board?(current_board)).to eq(false)
        end
    end
end