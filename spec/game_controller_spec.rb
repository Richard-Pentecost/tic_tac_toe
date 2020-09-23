require_relative "../game_controller.rb"
require_relative "../board.rb"

describe GameController do
    context "initialize GameController" do
        it "initializes a new board" do
            expect(GameController.new.board.class).to be(Board)
        end
    end
end
