class MinimaxComputer
    attr_accessor :board_checker, :scores_hash

    def initialize(board_checker)
        @board_checker = board_checker
        @scores_hash = {}
    end

    def move(board)
        current_board = board.board
        available_moves = possible_moves(current_board)

        if available_moves.length == 1
            return available_moves[0]
        end


        if available_moves.length == 2

            @scores_hash = {}
            available_moves.each do |test_move|
                test_board = Board.new
                ##### Figure out how to copy board???
                test_board.board = [['O','X','X'],['X','_','_'],['X','O','O']]
                test_board.add_move(test_move[0], test_move[1], "O")

                if @board_checker.three_in_a_line?(test_board.board, 'X') == false and 
                    @board_checker.three_in_a_line?(test_board.board, 'O') == false and
                    @board_checker.full_board?(test_board.board) == false
                    
                    new_move = possible_moves(test_board.board)
                    test_board.add_move(new_move[0][0], new_move[0][1], "X")
                end
                puts "=================================="
                p test_board.board
                p board.board
                score = score_board(test_board.board)
                @scores_hash.merge!(test_move => score)

            end
        end
        puts "---------------------------------"
        puts @scores_hash

        best_move = @scores_hash.key(@scores_hash.values.min)
        return best_move
        
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