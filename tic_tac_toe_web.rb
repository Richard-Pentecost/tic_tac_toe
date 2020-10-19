require 'sinatra/base'
require "erb"

class TicTacToeWeb < Sinatra::Base
  enable :sessions

  get '/tictactoe' do
    @grid_values = { "A0" => session[:A0], "A1" => session[:A1], "A2" => session[:A2],
                    "B0" => session[:B0], "B1" => session[:B1], "B2" => session[:B2],
                    "C0" => session[:C0], "C1" => session[:C1], "C2" => session[:C2],}
    erb :tictactoe
  end

  post '/tictactoe' do

    grid_positions = [:A0, :A1, :A2, :B0, :B1, :B2, :C0, :C1, :C2]

    grid_positions.each do |position|
      session[position] = params[position] 
    end
    
    redirect "/tictactoe"
  end
end