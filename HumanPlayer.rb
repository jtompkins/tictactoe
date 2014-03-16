require_relative "Player.rb"

class HumanPlayer < Player
	def move
		puts "Please choose a space (1-9): "
		space = gets.chomp.to_i

		puts space
	end
end