require_relative "../tic_tac_toe_web"

describe TicTacToeWeb do

    include Rack::Test::Methods
    let!(:app) { TicTacToeWeb.new }
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
            get '/tictactoe'
            post '/tictactoe', :A0 => "X"

            #Assert
            expect(last_response).to be_ok 
        end

        it "displays X in the first grid position" do
            # Act
            get '/tictactoe'
            post '/tictactoe', :A0 => "X"

            #Assert
            expect(last_response.body).to have_tag('input', :with => { :type => "submit", :value => "X", :id => "A0" })
        end
    end

end