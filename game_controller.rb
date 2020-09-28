require_relative "board.rb"

class GameController
    attr_accessor :board
    def initialize(board)
        @board = board
    end

end