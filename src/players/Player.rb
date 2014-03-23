require_relative "../board"

class Player
	attr_reader :marker

	def initialize(board, marker)
		@board = board
		@marker = marker
	end

	def same_marker?(marker)
		Board.valid_marker?(marker) and @marker == marker
	end

	def move
		raise NotImplementedError
	end
end