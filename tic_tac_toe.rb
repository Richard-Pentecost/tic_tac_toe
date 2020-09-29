class TicTacToe
    attr_accessor :controller, :game_over
    def initialize(game_controller)
        @controller = game_controller
        @game_over = false
    end

    def show_board
        board = @controller.get_boardstate
        list = []
        board.each { |row| list << row.join("|") }
        puts list
    end

    def get_input
        puts "Please enter a valid move: "
        input = gets.chomp
        @game_over = true if input == 'quit'
        input
    end

    def player_move
        input = get_input
        coordinate_array = interpret_input(input)
        @controller.move(coordinate_array[0],coordinate_array[1])
    end

    def computer_move
        @controller.run_ai
    end

    def interpret_input(coordinates)
        letter_coords = { 'A' => 0, 'B' => 1, 'C' => 2}
        return [letter_coords[coordinates[0]], coordinates[1].to_i - 1]
    end

end
