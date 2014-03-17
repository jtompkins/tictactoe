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

**What's the cleanest way to exit a method mid-way?**

In the AI code, I do things like this:

````ruby
return @board.set find_empty_in_seq(winning), @marker if winning
````

...to execute some code and then exit the method. I'm not sure if my intent is clear here,
but doing this instead:

````ruby
if winning
	@board.set find_empty_in_seq(winning)
	return
end
````

...seems less clean. Maybe I'm just abusing the postfix conditionals too much, but doing it the one-liner way looks better when there's a bunch of them:

````ruby
def basic_strategy
	#look for a winning move, and make it if it exists
	winning = find_winning @marker

	return @board.set find_empty_in_seq(winning), @marker if winning

	#look for a threatening move,
	threatening = find_threatening opposite_side(@marker)

	return @board.set find_empty_in_seq(threatening), @marker if threatening

	#no winning or threatening moves, so let's just pick a spot
	#first, check the corners
	open_corner = find_open_corner

	return @board.set open_corner, @marker if open_corner

	#corner isn't open, check the center
	return @board.set @@spaces[:center], @marker unless @board.set? @@spaces[:center]

	#center isn't open, check the edges
	open_edge = find_open_edge

	return @board.set open_edge, @marker if open_edge

	#nothing is open, so just bail
end
````

**What's the best way to organize a project?**

Specifically, where do the files go? And do you capitalize the name of a file containing a class?