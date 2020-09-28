class TicTacToe
    attr_accessor :controller
    def initialize(game_controller)
        @controller = game_controller
    end

    def show_board
        puts "_|_|_\n_|_|_\n_|_|_"
    end

    def get_input
        puts "Please enter a valid move: "
        input = gets.chomp
    end
end

# def newName
#   puts 'Name please'
#   name = gets
#   name.chomp
# end
#  
# newName
# Name please
# Richard
# => "Richard"