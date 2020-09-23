require_relative '../board'

describe Board do
  context 'initialize board' do
    it 'create @board as an empty board array' do
      expect(described_class.new.board).to eq([['_','_','_'],['_','_','_'],['_','_','_']])
    end
  end
end