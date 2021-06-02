# frozen_string_literal: true

require_relative 'gamestate'

def input_request_column
  puts 'enter a nomber:'
  print "#{@game.player.name} =>"
  input = gets.chomp.to_i
  @game.place_checker(@grid[input - 1])
end

@game = Gamestate.new(true, true)
@grid = @game.grid

until @game.game_over == true
  puts ''
  @game.show_grid
  puts ''
  puts '-----------------------------------'
  puts '  1    2    3    4    5    6    7'
  puts "#{@game.player.color} checkers left: #{@game.player.checkers -= 1}"
  input_request_column
end
