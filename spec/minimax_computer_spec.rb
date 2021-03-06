require 'minimax_computer'
require 'board'
require 'board_checker'

describe MinimaxComputer do

    context 'Minimax Computer initialisation' do
        it 'initializes with a board_checker' do
            minimax_computer = MinimaxComputer.new("board_checker")
            expect(minimax_computer.board_checker).to eq('board_checker')
        end
    end

    context ".move" do
        before(:each) do
            @board = Board.new
            board_checker = BoardChecker.new
            @minimax_computer = MinimaxComputer.new(board_checker)
        end

        it "returns [1,1] when given B2 is only available move" do
            @board.board= [['O','X','X'],['X','_','O'],['X','O','O']]        
            expect(@minimax_computer.move(@board)).to eq([1,1])
        end

        it "returns [2,2] when given C3 is only available move" do
            @board.board = [['O','X','X'],['X','O','O'],['X','O','_']]
            expect(@minimax_computer.move(@board)).to eq([2,2])
        end

        it "returns [1,1] when given B2 is only available move" do
            @board.board = [['O','O','X'],['X','_','O'],['X','O','O']]
            expect(@minimax_computer.move(@board)).to eq([1,1])
        end
        

        it "returns [1,1] when a board with 2 options and B2 wins the game" do
            @board.board = [['O','X','X'],['X','_','_'],['X','O','O']]
            expect(@minimax_computer.move(@board)).to eq([1,1])
        end

        it "returns [0,2] when a board with 2 options and A3 wins the game" do 
            @board.board = [['O','X','X'],['X','X','_'],['_','O','O']]
            expect(@minimax_computer.move(@board)).to eq([0,2])
        end

        it "returns [1,2] when a board with 4 options and B3 wins the game" do
            @board.board = [['X','O','X'],['X','O','_'],['_','_','_']]
            expect(@minimax_computer.move(@board)).to eq([1,2])
        end
    end

    context '.score_board' do
        before(:each) do
            board_checker = double("board_checker")
            @minimax_computer = described_class.new(board_checker)
        end
        
        it 'given a board where X has won give a score of +1' do
            board = [['O','O','X'],['X','X','O'],['X','O','O']]
            allow(@minimax_computer.board_checker).to receive(:three_in_a_line?).and_return(true)
            expect(@minimax_computer.score_board(board)).to eq(1)
        end

        it 'given a board where O has won give a score of -1' do
            board = [['X','X','O'],['O','O','X'],['O','X','X']]
            allow(@minimax_computer.board_checker).to receive(:three_in_a_line?).with(board, "X").and_return(false)
            allow(@minimax_computer.board_checker).to receive(:three_in_a_line?).with(board, "O").and_return(true)
            expect(@minimax_computer.score_board(board)).to eq(-1)
        end

        it 'given a board where it is a draw a score of 0' do
            board = [['O','X','O'],['X','X','O'],['X','O','X']]
            allow(@minimax_computer.board_checker).to receive(:three_in_a_line?).with(board, "X").and_return(false)
            allow(@minimax_computer.board_checker).to receive(:three_in_a_line?).with(board, "O").and_return(false)
            expect(@minimax_computer.score_board(board)).to eq(0)
        end
    end

    context '.possible_moves' do
        it 'returns an empty array if there are no more moves available'do
            minimax_computer = described_class.new('board_checker')
            board = [['O','X','O'],['X','X','O'],['X','O','X']]
            expect(minimax_computer.possible_moves(board)).to eq([])
        end

        it 'returns an array of [0, 0] inside another array if there is a space at 0, 0' do
            minimax_computer = described_class.new('board_checker')
            board = [['_','X','O'],['X','X','O'],['X','O','X']]
            expect(minimax_computer.possible_moves(board)).to eq([[0,0]])
        end

        it 'returns an array of [1, 1] inside another array if there is a space at 1, 1' do
            minimax_computer = described_class.new('board_checker')
            board = [['O','X','O'],['X','_','O'],['X','O','X']]
            expect(minimax_computer.possible_moves(board)).to eq([[1,1]])
        end

        it 'returns an array of [1, 1] and [0, 0] inside another array if there is a space at 1, 1 and 0, 0' do
            minimax_computer = described_class.new('board_checker')
            board = [['_','X','O'],['X','_','O'],['X','O','X']]
            expect(minimax_computer.possible_moves(board)).to eq([[0,0],[1,1]])
        end

        it 'returns an array of [0, 1] and [1, 2] inside another array if there is a space at 1, 1 and 0, 0' do
            minimax_computer = described_class.new('board_checker')
            board = [['X','_','O'],['X','O','_'],['X','O','X']]
            expect(minimax_computer.possible_moves(board)).to eq([[1,0],[2,1]])
        end

        it 'returns an array of [2, 1], [0, 2], [1, 2] and [2, 2] inside another array' do
            minimax_computer = described_class.new('board_checker')
            board = [['X','O','X'],['X','O','_'],['_','_','_']]
            expect(minimax_computer.possible_moves(board)).to eq([[2,1],[0,2],[1,2],[2,2]])
        end
    end
        
end