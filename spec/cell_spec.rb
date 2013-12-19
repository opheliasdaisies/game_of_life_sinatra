require_relative "../lib/cell"
require_relative "../lib/board"

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end

describe "Cell" do

	it "Should create a cell with a state of dead if value is not passed into initialize" do
		cell = Cell.new
		cell.state.should eq("dead")
	end

	it "Should create a cell with a state of alive if alive value is passed into initialize" do
		cell = Cell.new("alive")
		cell.state.should eq("alive")
	end

	it "Should know what its position is in the array" do
		board = Board.new(3,3)
		cell = board.all_cells[1][1]
		cell.find_position(board)
		cell.row.should eq(1)
	end

	it "Should detect the neighbor to the north-west" do
		board = Board.new(3,3)
		board.starting_move!([[1,1],[0,0]])
		cell = board.all_cells[1][1]
		cell.find_neighbors(board)
		cell.neighbors.count.should eq(1)
	end

	it "Should detect the neighbor to the north" do
		board = Board.new(3,3)
		board.starting_move!([[1,1],[0,1]])
		cell = board.all_cells[1][1]
		cell.find_neighbors(board)
		cell.neighbors.count.should eq(1)
	end

	it "Should detect the neighbor to the north-east" do
		board = Board.new(3,3)
		board.starting_move!([[1,1],[0,2]])
		cell = board.all_cells[1][1]
		cell.find_neighbors(board)
		cell.neighbors.count.should eq(1)
	end

	it "Should detect the neighbors to the east and west" do
		board = Board.new(3,3)
		board.starting_move!([[1,1],[1,0],[1,2]])
		cell = board.all_cells[1][1]
		cell.find_neighbors(board)
		cell.neighbors.count.should eq(2)
	end

	it "Should detect the neighbors to the south, south-east, and south-west" do
		board = Board.new(3,3)
		board.starting_move!([[1,1],[2,0],[2,1],[2,2]])
		cell = board.all_cells[1][1]
		cell.find_neighbors(board)
		cell.neighbors.count.should eq(3)
	end

	it "Should kill a living cell" do
		cell = Cell.new
		cell.state = "alive"
		cell.die!
		cell.state.should eq("dead")
	end

	it "Should make a dead cell alive" do
		cell = Cell.new
		cell.live!
		cell.state.should eq("alive")
	end

	it "Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population." do
		board = Board.new(3,3)
		board.starting_move!([[1,1]])
		cell = board.all_cells[1][1]
		cell.find_neighbors(board)
		cell.under_population(board)
		cell.staged.should eq("die")
	end

	it "Rule 2: Any live cell with two or three live neighbours lives on to the next generation." do
		board = Board.new(3,3)
		board.starting_move!([[1,1],[0,1],[2,2]])
		cell = board.all_cells[1][1]
		cell.evaluate_cell(board)
		cell.staged.should eq(nil)
	end

	it "Rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding." do
		board = Board.new(3,3)
		board.starting_move!([[1,1],[0,0],[1,0],[2,1],[2,2]])
		cell = board.all_cells[1][1]
		cell.find_neighbors(board)
		cell.overcrowding(board)
		cell.staged.should eq("die")
	end

	it "Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction." do
		board = Board.new(3,3)
		board.starting_move!([[0,0],[1,0],[2,1]])
		cell = board.all_cells[1][1]
		cell.find_neighbors(board)
		cell.zombify(board)
		cell.staged.should eq("live")
	end

	it "Evaluates a cell to determine if it should live or die" do
		board = Board.new(3,3)
		board.starting_move!([[1,1],[0,0],[1,0],[2,1],[2,2]])
		cell = board.all_cells[1][1]
		cell.evaluate_cell(board)
		cell.staged.should eq("die")
	end

	it "Evaluates a cell to determine if it should live or die" do
		board = Board.new(3,3)
		board.starting_move!([[0,0],[1,0],[2,1]])
		cell = board.all_cells[1][1]
		cell.evaluate_cell(board)
		cell.staged.should eq("live")
	end

	it "Evaluates a cell if fewer than 8 neighbors exist" do
		board = Board.new(1,2)
		board.starting_move!([[0,0]])
		cell = board.all_cells[0][0]
		cell.evaluate_cell(board)
		cell.staged.should eq("die")
	end

end