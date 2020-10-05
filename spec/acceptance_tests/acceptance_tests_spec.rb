require_relative '../../tic_tac_toe.rb'
require_relative '../../board.rb'
require_relative '../../game_controller.rb'
require_relative '../../computer.rb'

describe "Game initiation" do
    before(:each) do
        board = Board.new
        computer = Computer.new
        game_controller = GameController.new(board, computer)
        @game = TicTacToe.new(game_controller)
    end

    context "player starts game" do
        it "displays an empty board" do
            grid = "_|_|_\n_|_|_\n_|_|_\n"
            expect {@game.show_board}.to output(grid).to_stdout
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
            expect {@game.show_board}.to output(grid).to_stdout
        end
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
            expect {@game.show_board}.to output(grid).to_stdout
        end
    end

    context "player enters invalid input" do
        it "prompts player until they make a valid move" do
            allow(@game).to receive(:gets).and_return('D4', 'A1')
            message = "Please enter a valid move: \nInvalid input\nPlease enter a valid move: \n"
            expect{@game.player_move}.to output(message).to_stdout
            grid = "X|_|_\n_|_|_\n_|_|_\n"
            expect {@game.show_board}.to output(grid).to_stdout
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
        xit 'ends the game with a message saying the player has won' do
            allow(@game).to receive(:gets).and_return('A1', 'A2', 'A3',)
            @game.player_move
            @game.computer_move
            @game.player_move
            @game.computer_move
            @game.player_move
            message = "CONGRATULATIONS!!! You beat our very advance AI!!\n"
            expect { @game.end_game_if_over }.to output(message).to_stdout
            expect(@game.game_over).to eq(true)  
        end
    end
end

