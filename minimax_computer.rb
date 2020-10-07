class MinimaxComputer
    attr_accessor :board_checker
    
    def initialize(board_checker)
        @board_checker = board_checker
    end

    def move(board)
        if board.flatten.count('_') == 1
            board.each_with_index do |row, row_index|
                row.each_with_index do |symbol, column_index|
                    if symbol == "_"
                        return [column_index, row_index]
                    end
                end
            end
        end

        [1,1]
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