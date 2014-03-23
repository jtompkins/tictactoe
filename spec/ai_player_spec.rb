require "minitest/autorun"

require_relative "../src/board"
require_relative "../src/players/ai_player"

describe AiPlayer do
	describe "when deciding on a move" do
		it "should properly identify the other player" do
			board = Board.new [:X, :X, nil, nil, nil, nil, nil, nil, nil]
			player = AiPlayer.new board, :X
			other_player = AiPlayer.new board, :O

			player.identify_other_player.must_equal :O
			other_player.identify_other_player.must_equal :X
		end

		it "should correctly identify a sequence that would win the game for itself" do
			board = Board.new [:X, :X, nil, nil, nil, nil, nil, nil, nil]
			player = AiPlayer.new board, :X

			test_seq = Sequence.new({1=>:X, 2=>:X, 3=>nil})

			threatening_seq = player.find_threatening :X

			threatening_seq.wont_equal nil
			(test_seq == threatening_seq).must_equal true
		end

		it "should correctly identify a sequence that would win the game for the other player" do
			board = Board.new [:X, :X, nil, nil, nil, nil, nil, nil, nil]
			player = AiPlayer.new board, :O

			test_seq = Sequence.new({1=>:X, 2=>:X, 3=>nil})

			threatening_seq = player.find_threatening player.identify_other_player

			(test_seq == threatening_seq).must_equal true
		end

		it "should play an open corner if there are no winning or threatening moves" do
			board = Board.new [ :O, :X, :O,
								nil, nil, nil,
								:X, nil, nil ]

			player = AiPlayer.new board, :X

			player.move

			board.get(9).must_equal :X
		end

		it "should play the center if there are no open corners" do
			board = Board.new [ :O, :X, :O,
								nil, nil, nil,
								:X, :O, :X ]

			player = AiPlayer.new board, :X

			player.move

			board.get(5).must_equal :X
		end

		it "should play an edge if the center is not open" do
			board = Board.new [ :O, :X, :O,
								:X, :O, nil,
								:X, :O, :X ]

			player = AiPlayer.new board, :X

			player.move

			board.get(6).must_equal :X
		end
	end
end