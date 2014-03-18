require_relative "Board"
require_relative "players/HumanPlayer"
require_relative "players/AiPlayer"

class TicTacToe
	def self.make_player(type, board, marker)
		if type == :human
			HumanPlayer.new board, marker
		else
			AiPlayer.new board, marker
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

	def print_board
		puts "Current Board"
		puts
		puts @board
		puts
	end

	def play
		system "clear" or system "cls"

		puts "Welcome to Tic-Tac-Toe. Here's the board:"
		puts
		puts @board
		puts

		loop do
			puts "Player #{@current_player.marker}, make your move."

			@current_player.move

			system "clear" or system "cls"

			if @board.won?
				print_board

				puts "Player #{@current_player.marker}, you won. Congratulations!"

				break
			elsif @board.tied?
				print_board

				puts "Tie game! Better luck next time."

				break
			else
				print_board

				switch_players
			end
		end
	end
end

def parse_arg(arg)
	if arg == "h" or arg == "human"
		:human
	elsif arg == "a" or arg == "ai"
		:ai
	else
		:ai
	end
end

if ARGV.length == 2
	game = TicTacToe.new parse_arg(ARGV[0]), parse_arg(ARGV[1])

	game.play
else
	puts "Usage: TicTacToe.rb {h|a} {h|a}"
end