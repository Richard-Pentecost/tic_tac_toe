class TicTacToe
    attr_accessor :controller, :game_over
    def initialize(game_controller)
        @controller = game_controller
        @game_over = false
        @grid_references = ['A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3']
    end

    def introduce_game
        instructions = "Welcome to Tic Tac Toe.\n"\
                        "INSTRUCTIONS:\n"\
                        "To win the game, get three in a line.\n"\
                        "To quit the game, type 'quit'.\n"\
                        "To make a move give a grid reference.\n"\
                        "  A|B|C\n1 _|_|_\n2 _|_|_\n3 _|_|_\n"\
                        "-----------------------------------------\n\n"

        puts instructions
    end

    def show_board
        board = @controller.get_boardstate
        list = []
        board.each { |row| list << row.join("|") }
        puts list
    end

    def get_input
        puts "Please enter a valid move: "
        gets.chomp
    end

    def quit_game
        @game_over = true
    end


    def player_move
        input = get_input

        if input == 'quit' 
            quit_game
            return
        end

        message = 'Invalid input'

        if valid_grid_reference?(input)
            coordinate_array = interpret_input(input)
            
            valid_move = @controller.cell_empty?(coordinate_array[0], coordinate_array[1])
            
            if valid_move
                @controller.move(coordinate_array[0],coordinate_array[1])
                return
            end
            message = 'Cannot place move here'
        end
        puts message
        player_move
    end

    def computer_move
        @controller.run_ai
    end

    def interpret_input(coordinates)
        letter_coords = { 'A' => 0, 'B' => 1, 'C' => 2}
        return [letter_coords[coordinates[0]], coordinates[1].to_i - 1]
    end

    def valid_grid_reference?(grid_reference)
        @grid_references.include? (grid_reference)
    end

    def end_game_if_over 
        game_status = @controller.get_game_status
        if game_status != 'pending'
            puts 'Game is drawn, there are no more moves!' if game_status == "drawn"
            puts 'CONGRATULATIONS!!! You beat our very advanced AI!!' if game_status == "X win"
            puts "UNLUCKY!!! Our very advanced AI outsmarted you!!" if game_status == "O win"
            quit_game
        end
    end
end
