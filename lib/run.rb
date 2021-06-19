# frozen_string_literal: true

require_relative 'gamestate'

# Gamestate.new(true) for single player
# Gamestate.new(true, true) for two player
@game = Gamestate.new

#### Game Flow ####
until @game.game_over == true
  if @game.checker_checker
    puts 'RESETTING'
    sleep(0.5)
    @game.game_reset
  else
    @game.turn
  end
end

@game.grid_view
puts 'Thanks for playing!'
