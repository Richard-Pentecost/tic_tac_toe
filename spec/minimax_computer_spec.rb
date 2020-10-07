require_relative '../minimax_computer.rb'

describe MinimaxComputer do

    context 'Minimax Computer initialisation' do
        it 'initializes with a board_checker' do
          minimax_computer = MinimaxComputer.new("board_checker")
          expect(minimax_computer.board_checker).to eq('board_checker')
        end
    end

    context ".move" do
        before(:each) do
            board_checker = double("board_checker")
            @minimax_computer = described_class.new(board_checker)
        end

        it "returns [1,1] when given B2 is only available move" do
            board = [['O','X','X'],['X','_','O'],['X','O','O']]
            expect(@minimax_computer.move(board)).to eq([1,1])
        end

        it "returns [2,2] when given C3 is only available move" do
            board = [['O','X','X'],['X','O','O'],['X','O','_']]
            expect(@minimax_computer.move(board)).to eq([2,2])
        end

        it "returns [1,1] when given B2 is only available move" do
            board = [['O','O','X'],['X','_','O'],['X','O','O']]
            expect(@minimax_computer.move(board)).to eq([1,1])
        end

        it "returns [1,1] when a board with 2 options and B2 wins the game" do
            board = [['O','X','X'],['X','_','_'],['X','O','O']]
            expect(@minimax_computer.move(board)).to eq([1,1])
        end

        xit "returns [0,2] when a board with 2 options and A3 wins the game" do
          board = [['O','X','X'],['X','X','_'],['_','O','O']]
          expect(@minimax_computer.move(board)).to eq([0,2])
        end
    end

    context '.score_board' do
        xit 'given a board where X has won give a score of +1' do
          board = [['O','O','X'],['X','X','O'],['X','O','O']]
          expect(@minimax_computer.score_board(board)).to eq(1)
        end
    end
end