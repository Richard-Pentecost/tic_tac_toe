require_relative '../../tic_tac_toe.rb'

describe "Game initiation" do
    context "player starts game" do
        xit "displays an empty board" do
            game = TicTacToe.new
            game.new_game
            grid = "_|_|_\n_|_|_\n_|_|_\n"
            expect {game.show_board}.to output(grid).to_stdout
        end

        # it 'asks user for move and receives input' do
        #     game = TicTacToe.new
        #     allow($stdin).to receive(:gets).and_return('hello')
        #     input = $stdin.gets
        #     expect(input).to eq('')
        # end
        xit "takes user's name and returns it" do
            game = TicTacToe.new
            expect(STDOUT).to receive(:puts).with("Please enter a valid move: ")
            allow(STDIN).to receive(:gets) { 'hello' }
            expect(game.get_input).to eq('hello')
        end
    end
end

# it "takes user's name and returns it" do
#     expect(STDOUT).to receive(:puts).with("What shall I call you today?")
#     allow(STDIN).to receive(:gets) { 'joe' }
#     expect(game.ask_for_name).to eq 'Joe'
#   end

# describe 'capture_name' do
#     it 'returns foo as input' do
#       allow($stdin).to receive(:gets).and_return('foo')
#       name = $stdin.gets

#       expect(name).to eq('food')
#     end
#   end
