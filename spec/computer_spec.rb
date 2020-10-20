require "computer"

describe Computer do
    before(:each) do
      @computer = described_class.new
    end
  
    context "given a board" do
        let(:board) {double('board')}
        it "returns the co-ordinates of a move" do
            allow(board).to receive(:board).and_return([['X','_','_'],['_','_','_'],['_','_','_']])
            expect(@computer.move(board)).to eq([1,0])
        end

        it "returns the co-ordinates of a move with different board" do
          allow(board).to receive(:board).and_return([['_','X','_'],['_','_','_'],['_','_','_']])
          expect(@computer.move(board)).to eq([0,0])
        end

        it "returns the co-ordinates of a move with different board" do
            allow(board).to receive(:board).and_return([['X','O','X'],['O','X','_'],['_','_','_']])
            expect(@computer.move(board)).to eq([2,1])
        end
        
    end
end