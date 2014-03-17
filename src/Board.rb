class Board
	include Enumerable

	@@sequences = [:top, :middle, :bottom, :left, :center, :right, :left_diag, :right_diag]

	def self.translate(cell)
		if cell < 1
			0
		elsif cell > 10
			8
		else
			cell - 1
		end
	end

	def self.valid_cell?(cell)
		cell > 0 and cell < 10
	end

	def self.valid_seq?(sequence)
		@@sequences.include? sequence
	end

	def self.valid_marker?(marker)
		marker == :X or marker == :O
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
		return "" unless Board.valid_cell? cell

		c = get cell

		c == nil ? cell : c
	end

	public

	def each
		@@sequences.each { |s| yield s }
	end

	def get(cell)
		return nil unless Board.valid_cell? cell

		@board[Board.translate cell]
	end

	def set(cell, marker)
		return nil unless Board.valid_cell? cell and Board.valid_marker? marker

		@board[Board.translate cell] = marker unless set? cell
	end

	def set?(cell, marker = nil)
		return false unless Board.valid_cell? cell

		if marker and Board.valid_marker? marker
			@board[Board.translate cell] == marker
		else
			@board[Board.translate cell] != nil
		end
	end

	def get_seq_index(sequence)
		return nil unless Board.valid_seq? sequence

		case sequence
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
	end

	def get_seq(sequence)
		return nil unless Board.valid_seq? sequence

		get_seq_index(sequence).collect { |i| get i }
	end

	def full?(sequence)
		if Board.valid_seq? sequence
			get_seq(sequence).count(nil) == 0
		else
			false
		end
	end

	def threatening?(sequence, marker = nil)
		return false if !Board.valid_seq?(sequence) or full? sequence

		if marker and Board.valid_marker? marker
			get_seq(sequence).count(marker) == 2
		else
			get_seq(sequence).count(nil) == 1
		end
	end

	def winning?(sequence, marker = nil)
		return false unless Board.valid_seq? sequence and full? sequence

		if marker and Board.valid_marker? marker
			get_seq(sequence).count { |m| m == marker } == 3
		else
			winning?(sequence, :X) or winning?(sequence, :O)
		end
	end

	def tied?
		all? { |s| full?(s) and !winning?(s) }
	end

	def won?
		any? { |s| winning? s }
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