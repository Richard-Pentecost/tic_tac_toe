class Board 
  attr_accessor :board
  def initialize
    @board = [['_','_','_'],['_','_','_'],['_','_','_']]
  end

  def add_move(x, y, symbol)
    @board = [['X','_','_'],['_','_','_'],['_','_','_']]
  end
end
