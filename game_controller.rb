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
        current_board = get_boardstate
        if current_board[row][column] == "_"
            return true
        end
        return false
    end

    def get_game_status
        current_board = get_boardstate
        return "X win" if three_in_a_line?(current_board, "X")
        return "O win" if three_in_a_line?(current_board, "O")
        return "drawn" if not current_board.flatten.include?('_')
        'pending'     
    end

    def three_in_a_line?(current_board, symbol)
        return true if three_in_a_row?(current_board, symbol)
        return true if three_in_a_column?(current_board, symbol)
        return true if three_in_a_diagonal?(current_board, symbol)
        false
    end

    def three_in_a_row?(current_board, symbol)
        current_board.each do |row|
            return true if row == [symbol,symbol,symbol]
        end
        false
    end

    def three_in_a_column?(current_board, symbol)
        (0..2).each do |column_index|
            if current_board[0][column_index] == symbol and 
                current_board[1][column_index] == symbol and 
                current_board[2][column_index] == symbol
                return true
            end
        end
        false
    end

    def three_in_a_diagonal?(current_board, symbol)
        if current_board[0][0] == symbol and
            current_board[1][1] == symbol and
            current_board[2][2] == symbol
            return true
        end
        if current_board[0][2] == symbol and
            current_board[1][1] == symbol and
            current_board[2][0] == symbol
            return true
        end
        false
    end

end