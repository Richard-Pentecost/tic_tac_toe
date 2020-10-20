require 'sinatra/base'
require "erb"
require_relative 'lib/game_controller'
require_relative 'lib/board'
require_relative 'lib/minimax_computer'
require_relative 'lib/board_checker'

class TicTacToeWeb < Sinatra::Base
  enable :sessions

  get '/tictactoe' do
    @grid_values = { "A0" => session[:A0], "A1" => session[:A1], "A2" => session[:A2],
                    "B0" => session[:B0], "B1" => session[:B1], "B2" => session[:B2],
                    "C0" => session[:C0], "C1" => session[:C1], "C2" => session[:C2],}
    erb :tictactoe
  end

  post '/tictactoe' do
    if session[:game_controller] == nil or params[:reset] == 'reset'
      game_controller = new_game_setup
      session[:game_controller] = game_controller
    end
    play_round
    update_ui_board
    redirect "/tictactoe"
  end

  private

  def new_game_setup
    board = Board.new
    board_checker = BoardChecker.new
    computer = MinimaxComputer.new(board_checker)
    game_controller = GameController.new(board, computer)
    game_controller.add_board_checker(board_checker)
    return game_controller
  end

  def grid_positions_array
    [:A0, :B0, :C0, :A1, :B1, :C1, :A2, :B2, :C2]
  end

  def play_round
    grid_positions = grid_positions_array

    grid_positions.each do |position|
      if params[position] != nil and session[position] == nil
        session[position] = params[position] 
        player_move = interpret_input(position.to_s)
        session[:game_controller].move(player_move[0], player_move[1])
        session[:game_controller].run_ai
      end   
    end
  end

  def update_ui_board 
    grid_positions = grid_positions_array
    
    board = session[:game_controller].board.board.flatten
    board.each_with_index do |position, index|
      position == "_" ? position = nil : position = position
      session[grid_positions[index]] = position 
    end
  end
  
  def interpret_input(coordinates)
    letter_coords = { 'A' => 0, 'B' => 1, 'C' => 2}
    return [letter_coords[coordinates[0]], coordinates[1].to_i]
  end
  
end