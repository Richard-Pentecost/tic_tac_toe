class GameController
    attr_accessor :board, :computer
    def initialize(board, computer)
        @board = board
        @computer = computer
        @turn = 0
    end

    def move(column, row) 
        sym = 'X'
        sym = 'O' if @turn.odd?
        @turn += 1
        @board.add_move(column, row, sym)
    end

    def get_boardstate
        @board.board
    end

    def run_ai
        coordinates = @computer.move(@board)
        move(coordinates[0], coordinates[1])
    end

    def cell_empty?(column, row)
        true
    end
end