require_relative "sequence"

class Board
	include Enumerable

	@@sequences = [:top, :middle, :bottom, :left, :center, :right, :left_diag, :right_diag]

	@@markers = [:X, :O]

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

	def self.translate(cell)
		if cell < 1
			0
		elsif cell > 9
			8
		else
			cell - 1
		end
	end

	def self.valid_seq?(sequence)
		@@sequences.include? sequence
	end

	def self.valid_space?(space)
		@@spaces.include? space
	end

	def self.valid_cell?(cell)
		cell > 0 and cell < 10
	end

	def self.valid_marker?(marker)
		@@markers.include? marker
	end

	def initialize(board = nil)
		if board and board.length >= 9
			@board = board[0..9]
		else
			@board = Array.new 9
		end
	end

	private

	def get_s(cell)
		raise ArgumentError, "Invalid cell." unless Board.valid_cell? cell

		c = get cell

		c == nil ? cell : c
	end

	public

	def each
		@@sequences.each { |s| yield get_seq s }
	end

	def get(cell)
		return nil unless Board.valid_cell? cell

		@board[Board.translate cell]
	end

	def set(cell, marker)
		raise ArgumentError, "Invalid marker." unless Board.valid_marker? marker

		if cell.is_a? Symbol
			raise ArgumentError, "Invalid space." unless Board.valid_space? cell

			c = @@spaces[cell]
		else
			raise ArgumentError, "Invalid cell." unless Board.valid_cell? cell

			c = cell
		end

		@board[Board.translate c] = marker unless set? c

	end

	def set?(cell, marker = nil)
		if marker and !Board.valid_marker? marker
			raise ArgumentError, "Invalid marker."
		end

		if cell.is_a? Symbol
			raise ArgumentError, "Invalid space." unless Board.valid_space? cell

			c = Board.translate @@spaces[cell]
		else
			raise ArgumentError, "Invalid cell." unless Board.valid_cell? cell

			c = Board.translate cell
		end

		marker ? @board[c] == marker : @board[c] != nil
	end

	def get_seq(sequence)
		raise ArgumentError, "Invalid sequence." unless Board.valid_seq? sequence

		indices = case sequence
			when :top
				[1, 2, 3]
			when :middle
				[4, 5, 6]
			when :bottom
				[7, 8, 9]

			when :left
				[1, 4, 7]
			when :center
				[2, 5, 8]
			when :right
				[3, 6, 9]

			when :left_diag
				[1, 5, 9]
			when :right_diag
				[3, 5, 7]
		end

		Sequence.new indices.map { |i| [i, get(i)]}.to_h
	end

	def empty?
		all? { |s| s.empty? }
	end

	def tied?
		all? { |s| s.full? and !s.winning? }
	end

	def won?
		any? { |s| s.winning? }
	end

	def to_s
		str = " #{get_s(1)} | #{get_s(2)} | #{get_s(3)} \n"
		str << "-----------\n"
		str << " #{get_s(4)} | #{get_s(5)} | #{get_s(6)} \n"
		str << "-----------\n"
		str << " #{get_s(7)} | #{get_s(8)} | #{get_s(9)} \n"

		str
	end
end