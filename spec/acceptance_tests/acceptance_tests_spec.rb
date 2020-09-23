
describe "Game initiation"
    context "player starts game" do
        it "displays an empty board" do
            game = TicTacToe.new
            grid = "_|_|_\n_|_|_\n_|_|_"
            expect(TicTacToe.show_board).to output(grid).to_stdout
        end
    end
end