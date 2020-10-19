require 'sinatra/base'
require "erb"
require_relative 'lib/game_controller'
require_relative 'lib/board'
require_relative 'lib/minimax_computer'
require_relative 'lib/board_checker'

class TicTacToeWeb < Sinatra::Base
  enable :sessions

  # def initialize(game_controller)
  #   @game_controller = game_controller
  # end

  get '/tictactoe' do
    @grid_values = { "A0" => session[:A0], "A1" => session[:A1], "A2" => session[:A2],
                    "B0" => session[:B0], "B1" => session[:B1], "B2" => session[:B2],
                    "C0" => session[:C0], "C1" => session[:C1], "C2" => session[:C2],}
    erb :tictactoe
  end

  post '/tictactoe' do
    if session[:game_controller] == nil
      board = Board.new
      board_checker = BoardChecker.new
      computer = MinimaxComputer.new(board_checker)
      game_controller = GameController.new(board, computer)
      game_controller.add_board_checker(board_checker)
      session[:game_controller] = game_controller
    end

    grid_positions = [:A0, :A1, :A2, :B0, :B1, :B2, :C0, :C1, :C2]

    grid_positions.each do |position|
      if params[position] != nil
        session[position] = params[position] 
        player_move = interpret_input(position.to_s)
        session[:game_controller].move(player_move[0], player_move[1])
        # session[:game_controller].run_ai
      end
      
    end
    redirect "/tictactoe"
  end

  private

  def interpret_input(coordinates)
    # puts "==============================="
    # p coordinates
    letter_coords = { 'A' => 0, 'B' => 1, 'C' => 2}
    return [letter_coords[coordinates[0]], coordinates[1].to_i]
  end
  
end