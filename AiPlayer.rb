require_relative "Board"
require_relative "Player"

class AiPlayer < Player
	def initialize(*)
		super

		@current_move = 1
	end

	def x_strategy
	end

	def o_strategy
	end

	def move
		if @marker == :X
			x_strategy
		else
			o_strategy
		end

		@current_move += 1
	end
end