require_relative "board"

class Sequence
	def initialize(cells)
		unless cells.is_a? Hash and cells.length == 3
			raise ArgumentError, "Cells must be a Hash of length 3."
		end

		@cells = cells
	end

	def first_empty
		@cells.select { |k,v| v == nil }.keys.first
	end

	def empty?
		@cells.values.all? { |v| v == nil }
	end

	def full?
		@cells.values.all? { |v| v != nil }
	end

	def threatening?(marker = nil)
		return false if full?

		if marker and Board.valid_marker? marker
			@cells.values.count(marker) == 2
		else
			threatening?(:X) or threatening?(:O)
		end
	end

	def winning?(marker = nil)
		return false unless full?

		if marker and Board.valid_marker? marker
			@cells.values.count(marker) == 3
		else
			winning?(:X) or winning?(:O)
		end
	end
end