require_relative "../computer.rb"

describe Computer do
    context "given a board" do
        let(:board) {double('board')}
        it "returns the co-ordinates of a move" do
            computer = Computer.new
            allow(board).to receive(:board).and_return([['X','_','_'],['_','_','_'],['_','_','_']])
            expect(computer.move(board)).to eq([1,0])
        end
    end
end