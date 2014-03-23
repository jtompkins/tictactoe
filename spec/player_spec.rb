require "minitest/autorun"

require_relative "../src/players/player"

describe Player do
	it "should correctly identify its own marker" do
		player = Player.new nil, :X

		player.same_marker?(:X).must_equal true
	end
end