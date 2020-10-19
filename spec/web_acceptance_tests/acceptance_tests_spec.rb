require_relative "../../tic_tac_toe_web"

describe TicTacToeWeb do

    include Rack::Test::Methods
    let(:app) { TicTacToeWeb.new }
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

end

# <div class="grid-container">

# <div class="top-row left-col grid-item" id="item1">
#   <form action"/ttt" method="post">
#     <input type="hidden" name="A1" value="X">
#     <input type="submit" value="<%= @A1 %>" class="ttt-button">
#   </form>
# </div>