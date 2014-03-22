require_relative "../Board"
require_relative "Player"

class AiPlayer < Player
	def other_player(marker)
		marker == :X ? :O : :X
	end

	def find_open_corner
		#select a random open corner
		corners = [:upper_left, :upper_right, :lower_left, :lower_right].shuffle!

		loop do
			break if corners.empty?

			corner = corners.pop

			return corner unless @board.set? corner
		end

		nil
	end

	def find_open_edge
		#select a random open edge
		edges = [:left, :right, :top, :bottom].shuffle!

		loop do
			break if edges.empty?

			edge = edges.pop

			return edge unless @board.set? edge
		end

		nil
	end

	def find_winning(marker)
		@board.select { |s| s.winning? marker }.first
	end

	def find_threatening(marker)
		@board.select { |s| s.threatening? marker }.first
	end

	def move
		#look for a winning move, and make it if it exists
		winning = find_winning @marker

		return @board.set winning.first_empty, @marker if winning

		#look for a threatening move,
		threatening = find_threatening other_player(@marker)

		return @board.set threatening.first_empty, @marker if threatening

		#no winning or threatening moves, so let's just pick a spot
		#first, check the corners
		open_corner = find_open_corner

		return @board.set open_corner, @marker if open_corner

		#corner isn't open, check the center
		return @board.set :center, @marker unless @board.set? :center

		#center isn't open, check the edges
		open_edge = find_open_edge

		return @board.set open_edge, @marker if open_edge

		#nothing is open, so just bail
	end
end