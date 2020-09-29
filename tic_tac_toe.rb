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
        @controller.move(0,0)
    end

    def computer_move
        @controller.run_ai
    end

    def interpret_input(coordinates)
        if coordinates[0] == 'B'
            return [1, 0]
        end
        if coordinates[0] == 'C'
            return [2, 0]
        end
        return [0, 0]
    end

end
