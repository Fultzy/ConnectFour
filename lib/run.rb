# frozen_string_literal: true

require_relative 'gamestate'

def input_request_column
  puts 'enter a nomber:'
  print "#{@game.player.name} =>"
  input = gets.chomp.to_i
  @game.place_checker(@grid[input - 1])
end

@game = Gamestate.new

until @game.game_over == true
  if @game.checker_checker
    puts ' RESETTING'
    sleep(1.5)
    @game.game_reset
  else
    puts ''
    @game.show_grid
    puts ''
    puts '-----------------------------------'
    puts '  1    2    3    4    5    6    7'
    puts "#{@game.player.color} checkers left: #{@game.player.checkers -= 1}"
    @game.place_checker(@game.grid[@game.player.input_request])
  end
end

puts ''
puts 'Thanks for playing!'
