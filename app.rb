require "bundler"
Bundler.require
require "sinatra/json"
require_relative "./lib/board"
require_relative "./lib/cell"

module Life
	class Game < Sinatra::Application
    helpers Sinatra::JSON
    enable :sessions
  
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, "public/app"
    end

    get "/" do
      File.read("public/app/index.html")
    end

    get "/random_board" do
      board = Board.new(30,40)
      board.starting_move!(board.randomize_start)
      turns = []
      turns << board.cell_states
      50.times do
        board.evaluate_all
        board.tick!
        turns << board.cell_states
      end
      session[:state] = turns[-1]

      json turns
    end

    get '/tick_board' do
      board = Board.new(30,40)
      # board.populate_board(session[:state])
      board.starting_move!(board.randomize_start)
      turns = []
      50.times do
        board.evaluate_all
        board.tick!
        turns << board.cell_states
      end
      json turns
    end

	end
end