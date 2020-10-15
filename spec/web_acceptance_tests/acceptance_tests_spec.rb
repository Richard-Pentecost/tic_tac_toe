require "tic_tac_toe_web"

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
    end

end

# <div class="grid-container">

# <div class="top-row left-col grid-item" id="item1">
#   <form action"/ttt" method="post">
#     <input type="hidden" name="A1" value="X">
#     <input type="submit" value="<%= @A1 %>" class="ttt-button">
#   </form>
# </div>