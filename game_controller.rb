require_relative "board.rb"

class GameController
    attr_accessor :board
    def initialize
        @board = Board.new
    end

end