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

    helpers do

      def run_game(game)
        moves = []
        loop do
          game.evaluate_all
          game.tick!
          moves << get_cell_state(game.all_cells)
        end
        moves
      end

      def get_cell_state(board)
        simple_board = []
        board.each do |row|
          row_array = []
          row.each do |cell|
            cell.state == "alive" ? row_array << 1 : row_array << 0
          end
          simple_board << row_array
        end
        simple_board
      end

    end

	end
end