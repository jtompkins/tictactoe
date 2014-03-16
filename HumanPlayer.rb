require_relative "Player"

class HumanPlayer < Player
	def move
		loop do
			break if @board.tied? or @board.won?

			puts "Please choose an open space (1-9):"

			space = gets.chomp.to_i

			if !Player.valid_space? space
				puts "Invalid space, please try again."
			elsif @board.set? space
				puts "That space is already taken, please try again."
			else
				@board.set space, @marker
				break
			end
		end
	end
end