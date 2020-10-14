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

                test_board.board = board.board.map(&:dup) 
                test_board.add_move(test_move[0], test_move[1], "O")

                if game_over?(test_board.board)
                    score = score_board(test_board.board)
                    @scores_hash.merge!(test_move => score)
                else 
                    new_move = possible_moves(test_board.board)
                    test_board.add_move(new_move[0][0], new_move[0][1], "X")
                    score = score_board(test_board.board)
                    @scores_hash.merge!(test_move => score)
                end
            end
        end

        if available_moves.length == 4
            @scores_hash = {}
            available_moves.each do |test_move|
                test_board = Board.new
                test_board.board = board.board.map(&:dup) 
                test_board.add_move(test_move[0], test_move[1], "O")

                if game_over?(test_board.board)
                    score = score_board(test_board.board)
                    @scores_hash.merge!(test_move => score)
                else
                    opponents_moves = possible_moves(test_board.board)
                    opponents_score_hash = {}

                    opponents_moves.each do |opponent_move|
                        opponent_board = Board.new
                        opponent_board.board = test_board.board.map(&:dup)
                        opponent_board.add_move(opponent_move[0], opponent_move[1], "X")

                        if game_over?(opponent_board.board)
                            score = score_board(opponent_board.board)
                            opponents_score_hash.merge!(opponent_move => score)
                        else
                            computer_second_moves = possible_moves(opponent_board.board)
                            computer_second_score_hash = {}

                            computer_second_moves.each do |computer_second_move|
                                comp_sec_board = Board.new
                                comp_sec_board.board = opponent_board.board.map(&:dup)
                                comp_sec_board.add_move(computer_second_move[0], computer_second_move[1], "O")

                                if game_over?(comp_sec_board.board)
                                    score = score_board(comp_sec_board.board)
                                    computer_second_score_hash.merge!(computer_second_move => score)
                                else
                                    poss_last_move = possible_moves(comp_sec_board.board)
                                    comp_sec_board.add_move(poss_last_move[0][0], poss_last_move[0][1], "X")
                                    score = score_board(comp_sec_board.board)
                                    computer_second_score_hash.merge!(poss_last_move[0] => score)
                                end
                            end

                            best_comp_score = computer_second_score_hash.values.min
                            opponents_score_hash.merge!(opponent_move => best_comp_score)
                        end
                    end
                    best_oppo_score = opponents_score_hash.values.max
                    @scores_hash.merge!(test_move => best_oppo_score)
                end
            end
        end


        best_move = @scores_hash.key(@scores_hash.values.min)
        return best_move
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

    def minimax_algorithm(board)
        
    end

    private

    def game_over?(board)
        @board_checker.three_in_a_line?(board, 'X') == true or 
        @board_checker.three_in_a_line?(board, 'O') == true or
        @board_checker.full_board?(board) == true
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