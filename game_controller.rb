class GameController
    attr_accessor :board
    def initialize(board)
        @board = board
    end

    def player_move(x, y) 
        @board.add_move(x, y, "X")
    end
end