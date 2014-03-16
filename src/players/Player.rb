class Player
	attr_reader :marker

	def initialize(board, marker)
		@board = board
		@marker = marker
	end

	def self.valid_marker?(marker)
		marker == :X or marker == :O
	end

	def self.valid_space?(space)
		space >= 1 and space < 10
	end

	def same_marker?(marker)
		valid_marker?(marker) and @marker == marker
	end

	def move
		raise NotImplementedError
	end
end