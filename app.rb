require "bundler"
Bundler.require
require_relative "./lib/board"
require_relative "./lib/cell"

module Life
	class Game < Sinatra::Application

		get '/' do
			starting_array = [[0,2],[4,3],[2,4],[4,4],[12,13],[13,12],[7,6],[5,15],[5,4],[3,4],[6,16]]
			@game = Board.new(20, 20)
			@game.starting_move!(starting_array)
			@game.evaluate_all

			erb :index
		end

	end
end