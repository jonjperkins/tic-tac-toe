class Board

	attr_accessor :player, :other_player, :grid, :already_chosen, :total_turns

	def initialize(player, other_player, grid)
		@player = player
		@other_player = other_player
		@grid = grid
		@already_chosen = []
		@total_turns = 0
	end

	def show_grid
		grid.each do |row|
			puts row.join(" | ")
			puts "----------"
		end
	end

	def set_starting_grid
		self.grid = [[1,2,3], [4,5,6], [7,8,9]]
	end

	def invalid_move(selection)
		if already_chosen.include? selection
			true
		elsif selection > 9 || selection < 1
			true
		else
			false
		end
	end

	def change_cell
		puts "Choose a number."
		selection = gets.chomp.to_i
		puts "-----"
		if invalid_move(selection) == false
			grid.each do |x| 
				if x.include? selection
					x.map! do |x| 
						if x == selection 
							already_chosen << x
							self.player.turn == true ? "X" : "O"
						else 
							x
						end
					
					end
					self.total_turns += 1
				end
			end
		else
			puts "Please try a valid selection."
			show_grid
			change_cell
		end
	end
end

class Game

		attr_accessor :board

	def initialize(board)
		@board = board
	end

	def game_loop

		board.set_starting_grid
		puts "Here's the tic-tac-toe board. Just enter a number when it's your turn \nfor the spot you'd like to select."
		board.show_grid
		start
		while board.total_turns <= 9
			if board.total_turns == 9
				puts "It's a draw."
				exit
			else
				board.change_cell
			end
			winning_conditions_horizontal
			winning_conditions_vertical
			winning_conditions_diagonal
			board.show_grid
			turn_change
		end
	end

	def draw
		if total_turns == 9
			puts "It's a draw."
			exit
		else
		end
	end

	def start
		puts "X starts first, it's your turn, #{board.player.name}."
	end

	def turn_change
		if board.player.turn == true
			board.player.turn = false
			board.other_player.turn = true
			puts "It's your turn, #{board.other_player.name}."
		else 
			board.player.turn = true
			board.other_player.turn = false
			puts "It's your turn, #{board.player.name}."
		end
	end

	def winning_conditions_vertical

		board.grid.transpose.find_index do |row| 
			if row.join == "XXX"
				puts "You win, #{board.player.name}!"
				board.show_grid
				exit
			elsif row.join == "OOO"
				puts "You win, #{board.other_player.name}!"
				board.show_grid
				exit
			else
			end
		
		end
	end 

	def winning_conditions_horizontal
		board.grid.find_index do |row| 
			if row.join == "XXX"
				puts "You win, #{board.player.name}!"
				board.show_grid
				exit
			elsif row.join == "OOO"
				puts "You win, #{board.other_player.name}!"
				board.show_grid
				exit
			else
			end
		
		end
	end 

	def winning_conditions_diagonal
		if [board.grid[0][0], board.grid[1][1], board.grid[2][2]].join == "XXX"
			puts "You win, #{board.player.name}!"
			board.show_grid
			exit
		elsif [board.grid[0][0], board.grid[1][1], board.grid[2][2]].join == "OOO"
			puts "You win, #{board.other_player.name}!"
			board.show_grid
			exit
		else
		end
			

		if [board.grid[0][2], board.grid[1][1], board.grid[2][0]].join == "XXX" 
			puts "You win, #{board.player.name}!"
			board.show_grid
			exit
		elsif [board.grid[0][2], board.grid[1][1], board.grid[2][0]].join == "OOO" 
			puts "You win, #{board.other_player.name}!"
			board.show_grid
			exit
		else
		end
	end 
end

class Player

	attr_accessor :turn
	attr_reader :name, :marker

	def initialize(name, marker, turn)
		puts "Please tell me your names. The player who wants to be X will \n type his/her name and press enter, then the second player \n will type his/her name and be O. Good luck!"
		@name = gets.chomp
		@marker = marker
		@turn = turn
	end
end

new_game = Game.new(Board.new(Player.new("Jon", "X", true), Player.new("Maeve", "O", false), (Array.new(3) { Array.new(3) {""} })))

new_game.game_loop







