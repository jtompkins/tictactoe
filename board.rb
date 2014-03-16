class Board
	include Enumerable

	@@sequences = [:top, :middle, :bottom, :left, :center, :right, :left_diag, :right_diag]
	@@markers = [:X, :O]

	def initialize(board = nil)
		if board and board.length >= 9
			@board = board[0..9]
		else
			@board = Array.new 9
		end
	end

	private

	def translate(cell)
		if cell < 1
			0
		elsif cell > 10
			8
		else
			cell - 1
		end
	end

	def valid_cell?(cell)
		cell > 0 and cell < 10
	end

	def valid_seq?(sequence)
		@@sequences.include? sequence
	end

	def valid_marker?(marker)
		@@markers.include? marker
	end

	def get_s(cell)
		return "" unless valid_cell? cell

		c = get cell

		c == nil ? cell : c
	end

	public

	def each
		@@sequences.each { |s| yield s }
	end

	def get(cell)
		return nil unless valid_cell? cell

		@board[translate cell]
	end

	def set(cell, marker)
		return nil unless valid_cell? cell and valid_marker? marker

		@board[translate cell] = marker unless set? cell
	end

	def set?(cell, marker = nil)
		return false unless valid_cell? cell

		if marker and valid_marker? marker
			@board[translate cell] == marker
		else
			@board[translate cell]
		end
	end

	def get_seq(sequence)
		return nil unless valid_seq? sequence

		case sequence
			when :top
				[get(1), get(2), get(3)]
			when :middle
				[get(4), get(5), get(6)]
			when :bottom
				[get(7), get(8), get(9)]

			when :left
				[get(1), get(4), get(7)]
			when :center
				[get(2), get(5), get(8)]
			when :right
				[get(3), get(6), get(9)]

			when :left_diag
				[get(1), get(5), get(9)]
			when :right_diag
				[get(3), get(5), get(7)]
		end
	end

	def full?(sequence)
		if valid_seq? sequence
			get_seq(sequence).count(nil) == 0
		else
			false
		end
	end

	def threatening?(sequence, marker = nil)
		return false if !valid_seq?(sequence) or full? sequence

		if marker and valid_marker? marker
			get_seq(sequence).count(marker) == 2
		else
			get_seq(sequence).count(nil) == 1
		end
	end

	def winning?(sequence, marker = nil)
		return false unless valid_seq? sequence and full? sequence

		if marker and valid_marker? marker
			get_seq(sequence).count { |m| m == marker } == 3
		else
			get_seq(sequence).count { |m| @@markers.include? m } == 3
		end
	end

	def tied?
		all? { |s| full?(s) and !winning?(s) }
	end

	def won?
		any? { |s| winning? s }
	end

	def winner
		each do |s|
			return get_seq(s)[0] if winning? s
		end
	end

	def to_s
		puts " #{get_s(1)} | #{get_s(2)} | #{get_s(3)} "
		puts "-----------"
		puts " #{get_s(4)} | #{get_s(5)} | #{get_s(6)} "
		puts "-----------"
		puts " #{get_s(7)} | #{get_s(8)} | #{get_s(9)} "
	end
end