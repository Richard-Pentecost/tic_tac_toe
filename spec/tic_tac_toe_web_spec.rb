require_relative "../tic_tac_toe_web"

describe TicTacToeWeb do

    include Rack::Test::Methods
    let!(:app) { TicTacToeWeb }
    context "goes to the page for the first time" do
        it "returns a 200 status code" do
            # Act
            get '/tictactoe'

            #Assert
            expect(last_response.status).to eq 200
        end

        it "shows an empty grid" do
            # Act
            get '/tictactoe'

            #Assert
            for row in 0..2
                for col in ["A", "B", "C"]
                    expect(last_response.body).to have_tag('input', :with => { :type => "hidden", :name => "#{col}#{row}" })
                end
            end
        end
    end

    context "user plays a first move on the grid" do
        it "sends a post request and returns a 200 status code" do
            # Act
            post '/tictactoe', :A0 => "X"
            get '/tictactoe'

            #Assert
            expect(last_response).to be_ok
        end

        it "displays X in the A0 position" do
            # Act
            post '/tictactoe', :A0 => "X"
            get '/tictactoe'            
            
            #Assert
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "X", :id => "A0" })
        end
        
        it "displays X in the C2 position" do
            # Act
            post '/tictactoe', :C2 => "X"
            get '/tictactoe'

            #Assert
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "X", :id => "C2" })
        end

        it "displays X in the B1 position" do
            # Act
            post '/tictactoe', :B1 => "X"
            get '/tictactoe'

            #Assert
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "X", :id => "B1" })
        end

        it "adds a move to the game controller" do
            # Act
            post '/tictactoe', :B1 => "X"
            get '/tictactoe'

            # Assert
            expect(session[:game_controller].board.board).to eq([['O','_','_'],['_','X','_'],['_','_','_']])
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "X", :id => "B1" })
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "O", :id => "A0" })
        end

        it "prevents user from playing in occupied space on the grid" do
            # Act
            post '/tictactoe', :B1 => "X"
            get '/tictactoe'
            post '/tictactoe', :AO => "X"
            get '/tictactoe'

            # Assert
            expect(session[:game_controller].board.board).to eq([['O','_','_'],['_','X','_'],['_','_','_']])
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "X", :id => "B1" })
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "O", :id => "A0" })
        end
    end

    context 'User presses reset button' do
        it 'resets to an emtpy board' do
            # Arrange
            post '/tictactoe', :B1 => "X"
            get '/tictactoe'

            # Act
            post '/tictactoe', :reset => 'reset'
            get '/tictactoe'

            # Asset
            expect(session[:game_controller].board.board).to eq([['_','_','_'],['_','_','_'],['_','_','_']])
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => nil, :id => "B1" })
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => nil, :id => "A0" })
        end

        it 'removes message if there is one' do
            # Arrange
            losing_message = "UNLUCKY!!! Our very advanced AI outsmarted you!!"
            post '/tictactoe', :B1 => "X" 
            post '/tictactoe', :C2 => "X" 
            post '/tictactoe', :B2 => "X" 

            # Act
            post '/tictactoe', :reset => 'reset'
            get '/tictactoe'

            # Asset
            expect(last_response.body).to_not include(losing_message)
        end

        it 'enables the grid buttons' do
            # Arrange
            post '/tictactoe', :B1 => "X" 
            post '/tictactoe', :C2 => "X" 
            post '/tictactoe', :B2 => "X" 
            post '/tictactoe', :A2 => "X"

            # Act
            post '/tictactoe', :reset => 'reset'
            get '/tictactoe'

            # Assert
            for row in 0..2
                for col in ["A", "B", "C"]
                    check_cell_enabled(last_response.body, col, row)
                    #expect(last_response.body).to_not have_tag('input', :with => { :type => "submit", :disabled => 'disabled' , :id => "#{col}#{row}" })
                end
            end
        end
    end

    context "Game has finished" do
        it 'shows a message when player has lost' do
            # Arrange
            losing_message = "UNLUCKY!!! Our very advanced AI outsmarted you!!"
            post '/tictactoe', :B1 => "X" 
            post '/tictactoe', :C2 => "X" 
            post '/tictactoe', :B2 => "X" 

            # Act
            get '/tictactoe'

            # Assert
            expect(last_response.body).to include(losing_message)
        end

        it "doesn't show a message when the game is active" do
            # Arrange
            losing_message = "UNLUCKY!!! Our very advanced AI outsmarted you!!"
            post '/tictactoe', :B1 => "X" 

            # Act
            get '/tictactoe'

            # Assert
            expect(last_response.body).to_not include(losing_message)
        end

        it "shows a message saying board is drawn when there are no more moves" do
            # Arrange
            drawn_message = "Game is drawn, there are no more moves!"
            post '/tictactoe', :B1 => "X" 
            post '/tictactoe', :B0 => "X" 
            post '/tictactoe', :A1 => "X" 
            post '/tictactoe', :C2 => "X" 
            post '/tictactoe', :A2 => "X" 

            # Act
            get '/tictactoe'

            # Assert
            expect(last_response.body).to include(drawn_message)
        end

        it 'locks the board when player has lost' do
            # Arrange
            post '/tictactoe', :B1 => "X" 
            post '/tictactoe', :C2 => "X" 
            post '/tictactoe', :B2 => "X" 

            # Act
            post '/tictactoe', :A2 => "X"
            get '/tictactoe'

            # Assert
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => nil, :id => "A2" })
        end

        it 'it disables the buttons' do
            # Arrange
            post '/tictactoe', :B1 => "X" 
            post '/tictactoe', :C2 => "X" 
            post '/tictactoe', :B2 => "X" 

            # Act
            post '/tictactoe', :A2 => "X"
            get '/tictactoe'

            # Assert
            for row in 0..2
                for col in ["A", "B", "C"]
                    expect(last_response.body).to have_tag('input', :with => { :type => "submit", :disabled => 'disabled' , :id => "#{col}#{row}" })
                end
            end
        end
    end

end

def check_cell_enabled(response_body, col, row)
    expect(response_body).to_not have_tag('input', :with => { :type => "submit", :disabled => 'disabled' , :id => "#{col}#{row}" })
end