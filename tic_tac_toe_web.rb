require 'sinatra/base'
require "erb"
require_relative 'lib/game_controller'
require_relative 'lib/board'
require_relative 'lib/minimax_computer'
require_relative 'lib/board_checker'

class TicTacToeWeb < Sinatra::Base
  enable :sessions

  get '/' do
    redirect "/tictactoe"
  end
  
  get '/tictactoe' do
    @grid_values = { "A0" => session[:A0], "A1" => session[:A1], "A2" => session[:A2],
                    "B0" => session[:B0], "B1" => session[:B1], "B2" => session[:B2],
                    "C0" => session[:C0], "C1" => session[:C1], "C2" => session[:C2],}
    @message = session[:message]
    # @game_over = session[:game_over]
    erb :tictactoe
  end

  post '/tictactoe' do
    if session[:game_controller] == nil or params[:reset] == 'reset'
      game_controller = new_game_setup
      session[:game_controller] = game_controller
      session[:game_over] = false
      reset_message
    end

    play_round if not session[:game_over]
    

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
        end_game_if_over
        break if session[:game_over]
        session[:game_controller].run_ai
        end_game_if_over
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

  def end_game_if_over 
    game_status = session[:game_controller].get_game_status
    if game_status != 'pending'
      session[:message] = 'Game is drawn, there are no more moves!' if game_status == "drawn"
      session[:message] = 'CONGRATULATIONS!!! You beat our very advanced AI!!' if game_status == "X win"
      session[:message] = "UNLUCKY!!! Our very advanced AI outsmarted you!!" if game_status == "O win"
      session[:game_over] = true
    end
  end

  def reset_message
    session[:message] = nil
  end
end