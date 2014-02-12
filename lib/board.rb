class Board
	attr_reader :height, :width
	attr_accessor :all_cells, :live_cells, :new_cells

	def initialize(height, width)
		@height = height
		@width = width
		@all_cells = create
	end

	def create
		array = []
		height.times { array << [] }
		array.each do |empty_nest|
			width.times {empty_nest << Cell.new}
		end
		array
	end

	def starting_move!(array)
		@live_cells = coordinates(array)
		live_cells.each do |coordinate|
			all_cells[coordinate.y][coordinate.x].state = "alive"
		end
	end

  def randomize_start
    starting_array = []
    cell_total = self.height * self.width
    min = (cell_total*0.15).to_i
    max = (cell_total*0.75).to_i
    rand(min..max).times do
      row = self.all_cells.sample
      column = row.sample
      starting_array << [self.all_cells.index(row), row.index(column)]
    end
    starting_array.uniq!
  end

	def evaluate_all
		all_cells.each do |row|
			row.each {|cell| cell.evaluate_cell(self)}
		end	
	end

	def tick!
		all_cells.each do |row|
			row.each do |cell|
				if cell.staged == "die"
					cell.die!
				elsif cell.staged == "live"
					cell.live!
				else
					cell.state
				end
				cell.clear_staging
			end
		end
	end

  def cell_states
    all_cells.map do |row|
      row.map do |cell|
        cell.state
      end
    end
  end

	Position = Struct.new(:y, :x)
	def coordinates(array)
		array.collect do |item|
			Position.new(item[0], item[1])
		end
	end

end