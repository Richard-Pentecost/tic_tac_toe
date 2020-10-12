class MinimaxComputer
    attr_accessor :board_checker

    def initialize(board_checker)
        @board_checker = board_checker
    end

    def move(board)
        current_board = board.board
        available_moves = possible_moves(current_board)

        if available_moves.length == 1
            return available_moves[0]
        end


        if available_moves.length == 2
            high_score = -10
            best_move = []
            available_moves.each do |test_move|
                test_board = board.clone
                test_board.add_move(test_move)
                score = score_board(test_board.board)
                if score > high_score
                    best_move = test_move
                    high_score == score
                end
            end
        end
        best_move
        # score_board()
        #[1,1]
    end

    def possible_moves(board)
        available_moves = []

        board.each_with_index do |row, row_index|
            row.each_with_index do |symbol, column_index|
                if symbol == "_"
                    available_moves << [column_index, row_index]
                end
            end
        end
        
        return available_moves
    end
    
    def score_board(board)
        return 1 if @board_checker.three_in_a_line?(board, "X")
        return -1 if @board_checker.three_in_a_line?(board, "O")
        0
    end
end


#Two moves left
# o x x
# x x  
#   o o



# One move left
# o x x
# x   o
# x o o

# o x x
# x o o
# x o 

# o o x
# x   x
# x o 