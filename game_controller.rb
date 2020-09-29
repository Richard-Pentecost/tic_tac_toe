class GameController
    attr_accessor :board, :computer
    def initialize(board, computer)
        @board = board
        @computer = computer
        @turn = 0
    end

    def move(x, y) 
        sym = 'X'
        sym = 'O' if @turn.odd?
        @turn += 1
        @board.add_move(x, y, sym)
    end

    def get_boardstate
        @board.board
    end

    def run_ai
        coordinates = @computer.move(@board)
        move(coordinates[0], coordinates[1])
    end
end