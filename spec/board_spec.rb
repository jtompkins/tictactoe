require "minitest/autorun"

require_relative "../src/board"
require_relative "../src/sequence"

describe Board do
	describe "a board has some capabilities that are always available" do
		it "should identify only :X and :O as valid markers" do
			Board.valid_marker?(:X).must_equal true
			Board.valid_marker?(:O).must_equal true

			Board.valid_marker?("hey").must_equal false
			Board.valid_marker?(:hey).must_equal false
		end

		it "should identify any integer from 1-9 as a valid cell" do
			(1...9).each do |i|
				Board.valid_cell?(i).must_equal true
			end

			Board.valid_cell?(0).must_equal false
			Board.valid_cell?(10).must_equal false
		end

		it "should identify only properly named spaces as valid" do
			cells = [
				:upper_left,
				:upper_right,
				:lower_left,
				:lower_right,
				:center,
				:top,
				:left,
				:right,
				:bottom
			]

			cells.each { |c| Board.valid_space?(c).must_equal true }

			Board.valid_space?(:middle).must_equal false
		end

		it "should identify only properly named sequences as valid" do
			sequences = [
				:top,
				:middle,
				:bottom,
				:left,
				:center,
				:right,
				:left_diag,
				:right_diag
			]

			sequences.each { |s| Board.valid_seq?(s).must_equal true }

			Board.valid_seq?(:hey).must_equal false
		end

		it "should translate the integers 1-9 into zero-based array indices" do
			(1...9).each do |i|
				Board.translate(i).must_equal (i - 1)
			end
		end

		it "should translate integers outside of the valid set as though they were 1 or 9" do
			Board.translate(10).must_equal 8

			Board.translate(0).must_equal 0
			Board.translate(-1).must_equal 0
			Board.translate(-2).must_equal 0
		end
	end

	describe "a board should always" do
		it "should generate a list of all the valid sequences" do
			board = Board.new Array.new(9, nil)

			board.count.must_equal 8
		end

		it "should allow a marker to be placed in an empty cell" do
			board = Board.new Array.new(9, nil)

			board.set 1, :X

			board.get(1).must_equal :X
		end

		it "should not allow a cell with a marker in it to be overwritten" do
			board = Board.new Array.new(9, nil)

			board.set 1, :X

			board.get(1).must_equal :X

			board.set 1, :O

			board.get(1).must_equal :X
		end

		it "should allow you to check if a cell is already marked" do
			board = Board.new Array.new(9, nil)

			board.set 1, :X

			board.set?(1).must_equal true
		end

		it "should allow you to check if a cell is marked with a specific marker" do
			board = Board.new Array.new(9, nil)

			board.set 1, :X

			board.set?(1, :X).must_equal true
			board.set?(1, :O).must_equal false
		end

		it "should allow you to mark a cell with a number or a symbol" do
			board = Board.new Array.new(9, nil)

			board.set :upper_left, :X
			board.set 2, :X

			board.set?(1).must_equal true
			board.set?(2).must_equal true
		end

		it "should allow you to check a cell with a number or a symbol" do
			board = Board.new Array.new(9, nil)

			board.set :upper_left, :X

			board.set?(:upper_left).must_equal true
			board.set?(:upper_left, :X).must_equal true
			board.set?(:upper_left, :O).must_equal false
		end

		it "should return a specific sequence by name" do
			board = Board.new Array.new(9, nil)

			test_seq = Sequence.new({1=>nil, 5=>nil, 9=>nil})
			seq = board.get_seq :left_diag

			(seq == test_seq).must_equal true
		end
	end

	describe "when the board is empty" do
		it "should indicate that the board is empty" do
			board = Board.new Array.new(9, nil)

			board.empty?.must_equal true
		end
	end

	describe "when the board has a winning sequence" do
		it "should indicate that there is a winner" do
			board = Board.new [:X, :X, :X, nil, nil, nil, nil, nil, nil]

			board.won?.must_equal true
		end

		it "should not describe a tied board as having a winner" do
			board = Board.new [:X, :O, :X, :O, :X, :O, :O, :X, :O]

			board.won?.wont_equal true
		end

		it "should not describe an empty board as having a winner" do
			board = Board.new Array.new(9, nil)

			board.won?.wont_equal true
		end

		it "should not describe an incomplete board as having a winner" do
			board = Board.new [:X, :X, :O, nil, nil, nil, nil, nil, nil]

			board.won?.wont_equal true
		end
	end

	describe "when the board is full and has no winner" do
		it "should indicate that the board is tied" do
			board = Board.new [:X, :O, :X, :O, :X, :O, :O, :X, :O]

			board.tied?.must_equal true
		end

		it "should not describe an empty board as being tied" do
			board = Board.new Array.new(9, nil)

			board.tied?.wont_equal true
		end

		it "should not describe an incomplete board has being tied" do
			board = Board.new [:X, :X, :O, nil, nil, nil, nil, nil, nil]

			board.tied?.wont_equal true
		end
	end
end