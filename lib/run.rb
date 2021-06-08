# frozen_string_literal: true

require_relative 'gamestate'

#### Game Flow ####
@game = Gamestate.new
@game.grid_view

until @game.game_over == true
  puts ''
  if @game.checker_checker
    @game.grid_view
    puts ' RESETTING'
    sleep(0.5)
    @game.game_reset
  else
    @game.grid_view
    puts "#{@game.player.name} checkers left: #{@game.player.checkers}"
    @game.place_checker(@game.grid[@game.player.input_request])
  end
end

@game.grid_view
puts 'Thanks for playing!'
