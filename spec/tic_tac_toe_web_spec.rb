require_relative "../tic_tac_toe_web"

describe TicTacToeWeb do

    include Rack::Test::Methods
    let(:app) { TicTacToeWeb.new }
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

end