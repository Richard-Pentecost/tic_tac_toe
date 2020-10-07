require_relative '../minimax_computer.rb'

describe MinimaxComputer do
    let(:minimax_computer) { MinimaxComputer.new }
    
    context ".move" do
        it "returns [1,1] when given B2 is only available move" do
            board = double('board')
            allow(board).to receive(:board).and_return([['O','X','X'],['X','_','O'],['X','O','O']])
            expect(minimax_computer.move(board)).to eq([1,1])
        end

        it "returns [2,2] when given C3 is only available move" do
            board = double('board')
            allow(board).to receive(:board).and_return([['O','X','X'],['X','O','O'],['X','O','_']])
            expect(minimax_computer.move(board)).to eq([2,2])
        end

        it "returns [1,1] when given B2 is only available move" do
          board = double('board')
          allow(board).to receive(:board).and_return([['O','O','X'],['X','_','O'],['X','O','O']])
          expect(minimax_computer.move(board)).to eq([1,1])
      end
    end
end