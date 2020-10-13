require_relative '../../tic_tac_toe.rb'
require_relative '../../board.rb'
require_relative '../../game_controller.rb'
require_relative '../../computer.rb'
require_relative '../../minimax_computer.rb'
require_relative '../../board_checker.rb'

describe 'Tic Tac Toe Game' do

    describe "Game initiation" do
        before(:each) do
            board = Board.new
            computer = 'computer'
            game_controller = GameController.new(board, computer)
            game_controller.add_board_checker(BoardChecker.new)
            @game = TicTacToe.new(game_controller)
        end

        context "player starts game" do
            it "displays the instructions and an empty board" do
                instructions = "Welcome to Tic Tac Toe.\n"\
                                "INSTRUCTIONS:\n"\
                                "To win the game, get three in a line.\n"\
                                "To quit the game, type 'quit'.\n"\
                                "To make a move give a grid reference.\n"\
                                "  A|B|C\n1 _|_|_\n2 _|_|_\n3 _|_|_\n"\
                                "-----------------------------------------\n\n"
                expect { @game.introduce_game }.to output(instructions).to_stdout
            end

            it "displays an empty board" do
                grid = "_|_|_\n_|_|_\n_|_|_\n"
                expect{ @game.show_board }.to output(grid).to_stdout
            end
        end

        context "players starts a game but decides to end game" do
            it "sets the game_over flag to true" do
                allow(@game).to receive(:gets).and_return('quit')
                @game.player_move
                expect(@game.game_over).to eq(true)
            end
        end

        context "player makes a move" do
            it "updates the board and shows it" do
                allow(@game).to receive(:gets).and_return('A1')
                @game.player_move
                grid = "X|_|_\n_|_|_\n_|_|_\n"
                expect { @game.show_board }.to output(grid).to_stdout
            end
        end
    end

    describe "Game play with basic AI" do
        before(:each) do
            board = Board.new
            computer = Computer.new
            game_controller = GameController.new(board, computer)
            game_controller.add_board_checker(BoardChecker.new)
            @game = TicTacToe.new(game_controller)
        end

        context "computer makes a move" do
            it "updates a board and shows it" do
                allow(@game).to receive(:gets).and_return('A1')
                @game.player_move
                @game.computer_move
                grid = "X|O|_\n_|_|_\n_|_|_\n"
                expect { @game.show_board }.to output(grid).to_stdout
            end
        end

        context "player tries to make a play in occupied cell" do
            it "prompts player until they make a valid move" do
                allow(@game).to receive(:gets).and_return('A1', 'A1', 'A2')
                @game.player_move
                message = "Please enter a valid move: \nCannot place move here\nPlease enter a valid move: \n"
                expect{@game.player_move}.to output(message).to_stdout
                grid = "X|_|_\nO|_|_\n_|_|_\n"
                expect { @game.show_board }.to output(grid).to_stdout
            end
        end

        context "player enters invalid input" do
            it "prompts player until they make a valid move" do
                allow(@game).to receive(:gets).and_return('D4', 'A1')
                message = "Please enter a valid move: \nInvalid input\nPlease enter a valid move: \n"
                expect{@game.player_move}.to output(message).to_stdout
                grid = "X|_|_\n_|_|_\n_|_|_\n"
                expect { @game.show_board }.to output(grid).to_stdout
            end
        end

        context 'there are no more available positions on the board' do
            it 'ends the game with a message saying the game is drawn' do
                allow(@game).to receive(:gets).and_return('B2', 'B1', 'A2', 'A3', 'C3')
                @game.player_move
                @game.computer_move
                @game.player_move
                @game.computer_move
                @game.player_move
                @game.computer_move
                @game.player_move
                @game.computer_move
                @game.player_move
                message = "Game is drawn, there are no more moves!\n"
                expect { @game.end_game_if_over }.to output(message).to_stdout
                expect(@game.game_over).to eq(true)  
            end
        end

        context "A line of of 3 X's" do
            it 'ends the game with a message saying the player has won' do
                allow(@game).to receive(:gets).and_return('A1', 'A2', 'A3',)
                @game.player_move
                @game.computer_move
                @game.player_move
                @game.computer_move
                @game.player_move
                message = "CONGRATULATIONS!!! You beat our very advanced AI!!\n"
                expect { @game.end_game_if_over }.to output(message).to_stdout
                expect(@game.game_over).to eq(true)  
            end
        end

        context "A line of of 3 O's" do
            it 'ends the game with a message saying the player has lost' do
                allow(@game).to receive(:gets).and_return('A3', 'B3', 'A2',)
                @game.player_move
                @game.computer_move
                @game.player_move
                @game.computer_move
                @game.player_move
                @game.computer_move
                message = "UNLUCKY!!! Our very advanced AI outsmarted you!!\n"
                expect { @game.end_game_if_over }.to output(message).to_stdout
                expect(@game.game_over).to eq(true)  
            end
        end
    end

    describe "Game play with Minimax AI" do
        before(:each) do
            board = Board.new
            board_checker = BoardChecker.new
            computer = MinimaxComputer.new(board_checker)
            game_controller = GameController.new(board, computer)
            game_controller.add_board_checker(board_checker)
            @game = TicTacToe.new(game_controller)
        end

        #xox
        #xo
        #
        context 'When there is an opportunity for the computer to win' do
            it 'computer plays the correct move and the game ends with a message saying player has lost' do
                allow(@game).to receive(:gets).and_return('A1', 'B1', 'C1', 'B2', 'A2')
                5.times { @game.player_move }
                @game.computer_move 
                message = "UNLUCKY!!! Our very advanced AI outsmarted you!!\n"
                expect { @game.end_game_if_over }.to output(message).to_stdout
                expect(@game.game_over).to eq(true) 
            end
        end
    end

end