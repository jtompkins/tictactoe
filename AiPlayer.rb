require_relative "Board"
require_relative "Player"

class AiPlayer < Player
	@@spaces = {
		upper_left: 1,
		upper_right: 3,
		lower_left: 7,
		lower_right: 9,

		center: 5,

		top: 2,
		left: 4,
		right: 6,
		bottom: 8
	}

	def opposite_side(marker)
		marker == :X ? :O : :X
	end

	def find_open_corner
		return @@spaces[:upper_left] unless @board.set? @@spaces[:upper_left]
		return @@spaces[:upper_right] unless @board.set? @@spaces[:upper_right]
		return @@spaces[:lower_left] unless @board.set? @@spaces[:lower_left]
		return @@spaces[:lower_right] unless @board.set? @@spaces[:lower_right]

		nil
	end

	def find_open_edge
		return @@spaces[:left] unless @board.set? @@spaces[:left]
		return @@spaces[:right] unless @board.set? @@spaces[:right]
		return @@spaces[:top] unless @board.set? @@spaces[:top]
		return @@spaces[:bottom] unless @board.set? @@spaces[:bottom]

		nil
	end

	def find_winning(marker)
		@board.select { |s| @board.winning? s, marker }.first
	end

	def find_threatening(marker)
		@board.select { |s| @board.threatening? s, marker }.first
	end

	def find_empty_in_seq(sequence)
		seq = @board.get_seq_index sequence

		seq.select { |i| !@board.set?(i) }.first
	end

	def basic_strategy
		#look for a winning move, and make it if it exists
		winning = find_winning @marker

		return @board.set find_empty_in_seq(winning), @marker if winning

		#look for a threatening move,
		threatening = find_threatening opposite_side(@marker)

		return @board.set find_empty_in_seq(threatening), @marker if threatening

		#no winning or threatening moves, so let's just pick a spot
		#first, check the center
		return @board.set @@spaces[:center], @marker unless @board.set? @@spaces[:center]

		#center isn't open, check the corners
		open_corner = find_open_corner

		return @board.set open_corner, @marker if open_corner

		#corners aren't open, check the edges
		open_edge = find_open_edge

		return @board.set open_edge, @marker if open_edge

		#nothing is open, so just bail
	end

	def move
		basic_strategy
	end
end