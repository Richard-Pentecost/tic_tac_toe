require_relative "../../tic_tac_toe_web"

describe TicTacToeWeb do

    include Rack::Test::Methods
    let!(:app) { TicTacToeWeb.new }
    context "goes to the page for the first time" do
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

    context "user clicks the first grid item" do
        it "displays an X in the grid at position B1" do
            # Act
            post '/tictactoe', :B1 => "X" 
            get '/tictactoe'

            #Assert
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "X", :id => "B1" })
        end

        it "displays the computers move with an 'O'" do
            # Act
            post '/tictactoe', :B1 => "X" 
            get '/tictactoe'

            #Assert
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "O", :id => "A0" })
        end
    end

    context "player loses the game" do
        it "displays an message to the user saying they've lost" do
            # Arrange
            losing_message = "UNLUCKY!!! Our very advanced AI outsmarted you!!"
            post '/tictactoe', :B1 => "X" 
            post '/tictactoe', :C2 => "X" 
            post '/tictactoe', :B2 => "X" 

            # Act
            get '/tictactoe'

            #Assert
            expect(last_response.body).to include(losing_message)
        end
    end
end
