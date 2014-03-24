# Learning Ruby - TicTacToe

I'm trying to learn Ruby, one program at a time. This time, I implemented a simple Tic-Tac-Toe game.

This is my first time out with Ruby, so the code might not be very good/idiomatic/whatever. Hopefully I'll get better over time.

## Usage

````
ruby TicTacToe.rb {a|h} {a|h}
````

The first argument is the "X" player; the second is the "O" player. Use an "a" for a CPU-controlled player, or "h" for a human player.

## About the AI player

The AI player's strategy is very simple:

1. Check for a winning move. If one exists, play it.
1. If the other player has a move that threatens to win the game, block it.
1. If there isn't a winning move or a blocking move, look for an open corner, and play there.
1. If there isn't an open corner, play the center.
1. If the center isn't open, play an edge.

## Things I'm Not Sure About

**What's the best way to declare a class method?**

I've seen both

````ruby
def self.class_method
end
````

...and

````ruby
class << self
	def class_method
	end
end
````

...and I'm really not sure which one is the preferred method.