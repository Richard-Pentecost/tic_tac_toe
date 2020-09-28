class TicTacToe
    attr_accessor :controller, :game_over
    def initialize(game_controller)
        @controller = game_controller
        @game_over = false
    end

    def show_board
        puts "_|_|_\n_|_|_\n_|_|_"
        # board = @controller.get_boardstate
        # puts board.join(',')
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
end
