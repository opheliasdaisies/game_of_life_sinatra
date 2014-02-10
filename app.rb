require "bundler"
Bundler.require
require_relative "./lib/board"
require_relative "./lib/cell"

module Life
	class Game < Sinatra::Application

		get '/:height/:width' do
			@game = Board.new(params[:height].to_i, params[:width].to_i)
			@game.starting_move!(@game.randomize_start)
			# @game.evaluate_all

			haml :index
		end

	end
end