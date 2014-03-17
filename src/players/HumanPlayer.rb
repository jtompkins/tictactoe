require_relative "Player"
require_relative "../Board"

class HumanPlayer < Player
	def move
		loop do
			break if @board.tied? or @board.won?

			puts "Please choose an open space (1-9):"

			cell = $stdin.gets.chomp.to_i

			if !Board.valid_cell? cell
				puts "Invalid space, please try again."
			elsif @board.set? cell
				puts "That space is already taken, please try again."
			else
				@board.set cell, @marker
				break
			end
		end
	end
end