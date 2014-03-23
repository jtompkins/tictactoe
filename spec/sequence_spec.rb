require "minitest/autorun"

require_relative "../src/sequence"

describe Sequence do
	describe "when the sequence is empty" do
		it "should tell us that it's empty" do
			seq = Sequence.new({1=>nil, 2=>nil, 3=>nil})

			seq.empty?.must_equal true
		end
	end

	describe "when the sequence is full" do
		it "should tell us that it's full" do
			seq = Sequence.new({1=>:X, 2=>:X, 3=>:X})

			seq.full?.must_equal true
		end

		it "should identify a winning sequence" do
			seq = Sequence.new({1=>:X, 2=>:X, 3=>:X})

			seq.winning?.must_equal true
		end

		it "shouldn't identify a winning sequence as threatening" do
			seq = Sequence.new({1=>:X, 2=>:X, 3=>:X})

			seq.threatening?.must_equal false
		end

		it "should identify a winning sequence for a specific player" do
			seq = Sequence.new({1=>:X, 2=>:X, 3=>:X})

			seq.winning?(:X).must_equal true
			seq.winning?(:O).must_equal false
		end

		it "shouldn't show a non-winning but full sequence as winning" do
			seq = Sequence.new({1=>:X, 2=>:O, 3=>:X})

			seq.winning?.must_equal false
		end

		it "shouldn't show a non-winning but full sequence as threatening" do
			seq = Sequence.new({1=>:X, 2=>:O, 3=>:X})

			seq.threatening?.must_equal false
		end
	end

	describe "when the sequence is in play" do
		it "shouldn't be full, empty, or winning" do
			seq = Sequence.new({1=>:X, 2=>:X, 3=>nil})

			seq.full?.must_equal false
			seq.winning?.must_equal false
			seq.empty?.must_equal false
		end

		it "should identify a threatening sequence" do
			seq = Sequence.new({1=>:X, 2=>:X, 3=>nil})

			seq.threatening?.must_equal true
		end

		it "should identify a threatening sequence for a specific player" do
			seq = Sequence.new({1=>:X, 2=>:X, 3=>nil})

			seq.threatening?(:X).must_equal true
			seq.threatening?(:O).must_equal false
		end

		it "shouldn't identify an empty sequence as threatening" do
			seq = Sequence.new({1=>nil, 2=>nil, 3=>nil})

			seq.threatening?.must_equal false
		end

		it "shouldn't identify a mostly-full sequence as threatening" do
			seq = Sequence.new({1=>:X, 2=>nil, 3=>:O})

			seq.threatening?.must_equal false
		end

		it "should find an open cell in a sequence" do
			seq = Sequence.new({1=>:X, 2=>nil, 3=>:O})

			seq.first_empty.must_equal 2
		end

		it "should find the first open cell in a sequence with multiple open cells" do
			seq = Sequence.new({1=>:X, 2=>nil, 3=>nil})

			seq.first_empty.must_equal 2
			seq.first_empty.wont_equal 3
		end
	end
end