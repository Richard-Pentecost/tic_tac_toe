class GameController
    attr_accessor :board, :computer
    def initialize(board, computer)
        @board = board
        @computer = computer
    end

    def move(x, y) 
        @board.add_move(x, y, "X")
    end

    def get_boardstate
        @board.board
    end
end