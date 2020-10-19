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

end