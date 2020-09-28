require_relative "../game_controller.rb"

describe GameController do
    context "initialize GameController" do
        it "initializes a new board" do
            board = 'board'
            expect(GameController.new(board).board).to eq('board')
        end
    end

    context "player_move" do
        let(:board) { spy("board") }
        it "instructs board to add a move" do
            game_controller = GameController.new(board)
            game_controller.player_move(0,1)
            expect(game_controller.board).to have_received(:add_move).with(0, 1, "X")
        end
    end
end