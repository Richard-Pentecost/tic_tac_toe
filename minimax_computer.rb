class MinimaxComputer
    attr_accessor :board_checker

    def initialize(board_checker)
        @board_checker = board_checker
    end

    def move(board)
        current_board = board.board
        if current_board.flatten.count('_') == 1
            current_board.each_with_index do |row, row_index|
                row.each_with_index do |symbol, column_index|
                    if symbol == "_"
                        return [column_index, row_index]
                    end
                end
            end
        end
        
        # score_board()
        [1,1]
    end

    # This needs to be expanded to work with any number of possible moves
    # It currently works only with 0 or 1
    def possible_moves(board)
        return [] if not board.flatten.include?('_')
        if board.flatten.count('_') == 1
            board.each_with_index do |row, row_index|
                row.each_with_index do |symbol, column_index|
                    if symbol == "_"
                        return [[column_index, row_index]]
                    end
                end
            end
        end
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