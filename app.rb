require_relative "./lib/board"
require_relative "./lib/cell"


def visualize(array)
	array.each do |row|
		row.each do |cell|
			print "O" if cell.state == "alive"
			print "." if cell.state == "dead"
		end
		puts
	end
	puts
	puts
end


starting_array = [[8,8],[8,9],[8,11],[9,8],[9,9],[10,10]]
game = Board.new(12, 20)
game.starting_move!(starting_array)
visualize(game.all_cells)
50.times do
	game.evaluate_all
	game.tick!
	visualize(game.all_cells)
	sleep(1)
end
