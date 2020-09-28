require_relative "../game_controller.rb"

describe GameController do
    context "initialize GameController" do
        it "initializes a new board" do
            board = 'board'
            expect(GameController.new(board).board).to eq('board')
        end
    end
end
