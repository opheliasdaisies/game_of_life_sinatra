require "bundler"
Bundler.require
require "sinatra/json"
require_relative "./lib/board"
require_relative "./lib/cell"

module Life
	class Game < Sinatra::Application
    helpers Sinatra::JSON
  
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, "public"
    end

    get "/" do
      File.read("public/app/index.html")
    end

    get "/random_board" do
      board = Board.new(10,10)
      board.starting_move!(board.randomize_start)
      turns = []
      turns << board.cell_states
      50.times do
        board.evaluate_all
        board.tick!
        turns << board.cell_states
      end
      json turns
    end

    # post '/tick_board' do
    #   board = Board.new(10,10)
    #   board.starting_move!(params[:board])
    #   board.tick
    #   json board.cell_states
    # end

	end
end