class MinimaxComputer
  def move(board)
    current_board = board.board

    current_board.each_with_index do |row, row_index|
        row.each_with_index do |symbol, column_index|
            if symbol == "_"
                return [column_index, row_index]
            end
        end
    end
  end
end





# o x x
# x   o
# x o o

# o x x
# x o o
# x o 

# o o x
# x   x
# x o 