require 'sinatra/base'
require "erb"

class TicTacToeWeb < Sinatra::Base
  get '/tictactoe' do
    @grid_values = { "A0" => " ", "A1" => " ", "A2" => " ",
                    "B0" => " ", "B1" => " ", "B2" => " ",
                    "C0" => " ", "C1" => " ", "C2" => " ",}
    erb :tictactoe
  end
end