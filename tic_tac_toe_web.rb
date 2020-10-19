require 'sinatra/base'
require "erb"

class TicTacToeWeb < Sinatra::Base
  enable :sessions

  get '/tictactoe' do
    @grid_values = { "A0" => session[:A0], "A1" => " ", "A2" => " ",
                    "B0" => " ", "B1" => " ", "B2" => " ",
                    "C0" => " ", "C1" => " ", "C2" => session[:C2],}
    erb :tictactoe
  end

  post '/tictactoe' do
    session[:A0] = params[:A0] 
    session[:C2] = params[:C2]

    redirect "/tictactoe"
  end
end