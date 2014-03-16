require_relative "Board"
require_relative "HumanPlayer"
require_relative "AiPlayer"

class TicTacToe
	class << self
		def make_player(type, board, marker)
			if type == :human
				HumanPlayer.new board, marker
			else
				AiPlayer.new board, marker
			end
		end
	end

	def initialize(x_player, o_player)
		@board = Board.new

		@x_player = TicTacToe.make_player x_player, @board, :X
		@o_player = TicTacToe.make_player o_player, @board, :O

		@current_player = @x_player
	end

	def switch_players
		if @current_player.marker == :X
			@current_player = @o_player
		else
			@current_player = @x_player
		end
	end

	def play
		puts "Welcome to Tic-Tac-Toe. Here's the board:"

		puts @board

		loop do
			puts "Player #{@current_player.marker}, make your move."

			@current_player.move

			puts

			if @board.won?
				puts "Player #{@current_player.marker}, you won. Congratulations!"

				puts @board

				break
			elsif @board.tied?
				puts "Tie game! Better luck next time."

				puts @board

				break
			end

			puts @board

			switch_players
		end
	end
end