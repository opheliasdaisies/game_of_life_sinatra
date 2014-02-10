require "bundler"
Bundler.require
require_relative "./lib/board"
require_relative "./lib/cell"

module Life
	class Game < Sinatra::Application

		get '/:height/:width' do
			starting_array = [[0,2],[4,3],[2,4],[4,4],[12,13],[13,12],[7,6],[5,15],[5,4],[3,4],[6,16]]
			@game = Board.new(params[:height].to_i, params[:width].to_i)
			@game.starting_move!(starting_array)
			@game.evaluate_all

			haml :index
		end

	end
end