require "tic_tac_toe"

describe TicTacToe do
    before(:each) do
        game_controller = 'game controller'
        @game = described_class.new(game_controller)
    end

    context "TicTacToe initialization" do
        it "initializes a game controller" do
            expect(@game.controller).to eq('game controller')
        end
    end

    context "introduce_game" do
        
        it "displays the instructions" do
            instructions = "Welcome to Tic Tac Toe.\n"\
                            "INSTRUCTIONS:\n"\
                            "To win the game, get three in a line.\n"\
                            "To quit the game, type 'quit'.\n"\
                            "To make a move give a grid reference.\n"\
                            "  A|B|C\n1 _|_|_\n2 _|_|_\n3 _|_|_\n"\
                            "-----------------------------------------\n\n"
            expect { @game.introduce_game }.to output(instructions).to_stdout
        end

    end

    context "show_board" do
        let(:game_controller) {double('game controller')}

        it "shows the empty board" do
            allow(game_controller).to receive(:get_boardstate).and_return([['_','_','_'],['_','_','_'],['_','_','_']])
            game = described_class.new(game_controller)
            grid = "_|_|_\n_|_|_\n_|_|_\n"
            expect { game.show_board }.to output(grid).to_stdout
        end

        it "shows the board after a player has made a move" do
            allow(game_controller).to receive(:get_boardstate).and_return([['X','_','_'],['_','_','_'],['_','_','_']])
            game = described_class.new(game_controller)
            grid = "X|_|_\n_|_|_\n_|_|_\n"
            expect { game.show_board }.to output(grid).to_stdout
        end
    end

    context "get_input" do
        it "asks the user for a move" do
            value = allow(@game).to receive(:gets).and_return('hello')
            expect { @game.get_input }.to output("Please enter a valid move: \n").to_stdout
        end

        it "recieves user input" do
            value = allow(@game).to receive(:gets).and_return('hello')
            expect(@game.get_input).to eq('hello')
        end
    end

    context 'quit_game' do
        it "sets game over to true if the user inputs quit" do
            @game.quit_game
            expect(@game.game_over).to eq(true)
        end
    end


    context "player_move" do
        let(:game_controller) { spy("game_controller") }
        it "passed the player input to the game controller move method" do
            game = described_class.new(game_controller)
            allow(game).to receive(:gets).and_return('A1')
            game.player_move
            expect(game.controller).to have_received(:move).with(0,0)            
        end

        it "passed the player input to the game controller move method" do
            game = described_class.new(game_controller)
            allow(game).to receive(:gets).and_return('B1')
            game.player_move
            expect(game.controller).to have_received(:move).with(1,0)            
        end

        it "asks player to replay move if original move position is taken" do
            game = described_class.new(game_controller)
            allow(game.controller).to receive(:cell_empty?).with(1,0).and_return(false)
            allow(game.controller).to receive(:cell_empty?).with(0,0).and_return(true)
            allow(game).to receive(:gets).and_return('B1', 'A1')
            message = "Please enter a valid move: \nCannot place move here\nPlease enter a valid move: \n"
            expect { game.player_move }.to output(message).to_stdout           
        end

        it "asks player for another input if the input is invalid" do
            game = described_class.new(game_controller)
            allow(game).to receive(:gets).and_return('D4', 'A1')
            message = "Please enter a valid move: \nInvalid input\nPlease enter a valid move: \n"
            expect {game.player_move}.to output(message).to_stdout   
        end
    end

    context "computer_move" do
        let(:game_controller) { spy("game_controller") }
        it "calls method in game_controller for computer to make move" do
            game = described_class.new(game_controller)
            game.computer_move
            expect(game.controller).to have_received(:run_ai)            
        end
    end

    context "interpret input" do
        it "takes the given coordinates and returns them as number coordinates" do
            expect(@game.interpret_input('A1')).to eq([0, 0])
        end
        it "takes the given coordinates and returns them as number coordinates" do
            expect(@game.interpret_input('B1')).to eq([1, 0])
        end
        it "takes the given coordinates and returns them as number coordinates" do
            expect(@game.interpret_input('C1')).to eq([2, 0])
        end
    end

    context 'valid_grid_referecnce?' do
        it 'returns true if the input is valid' do
            expect(@game.valid_grid_reference?('A1')).to eq(true)
        end

        it 'returns false if the input invalid' do
            expect(@game.valid_grid_reference?('hello')).to eq(false)
        end

        it 'returns false if the input invalid' do
            expect(@game.valid_grid_reference?('D4')).to eq(false)
        end
    end

    context 'end_game_if_over' do
        let(:game_controller) { double("game_controller") }
        it "doesn't end game when game state is pending" do
            allow(game_controller).to receive(:get_game_status).and_return("pending")
            game = described_class.new(game_controller)
            game.end_game_if_over
            expect(game.game_over).to eq(false)
        end

        it 'set @game_over to true if game is drawn' do
            allow(game_controller).to receive(:get_game_status).and_return("drawn")
            game = described_class.new(game_controller)
            game.end_game_if_over
            expect(game.game_over).to eq(true)
        end

        it 'Prints drawn game message when game is drawn' do
            allow(game_controller).to receive(:get_game_status).and_return("drawn")
            game = described_class.new(game_controller)
            message = "Game is drawn, there are no more moves!\n"
            expect { game.end_game_if_over }.to output(message).to_stdout  
        end

        it 'set @game_over to true if game is won' do
            allow(game_controller).to receive(:get_game_status).and_return("X win")
            game = described_class.new(game_controller)
            game.end_game_if_over
            expect(game.game_over).to eq(true)
        end

        it 'Prints win game message when player wins game' do
            allow(game_controller).to receive(:get_game_status).and_return("X win")
            game = described_class.new(game_controller)
            message = "CONGRATULATIONS!!! You beat our very advanced AI!!\n"
            expect { game.end_game_if_over }.to output(message).to_stdout  
        end

        it 'Prints lose game message when player loses game' do
            allow(game_controller).to receive(:get_game_status).and_return("O win")
            game = described_class.new(game_controller)
            message = "UNLUCKY!!! Our very advanced AI outsmarted you!!\n"
            expect { game.end_game_if_over }.to output(message).to_stdout  
        end
    end
end




