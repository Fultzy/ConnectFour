# ConnectFour
  Ruby - 2.6.2 :: RSpec - 3.10 :: Bundler - 1.17.2

  Basic command line style connect 4 game.
  - Install:
    - clone this directory to your computer.
    - execute `ruby lib/run.rb` to run game.
    - `bundle install` for RSpec is available but not required.

  - Options
    - both players default to computers when `Gamestate.new` is called with no arguments. if you'd like to play against a computer or against another person you will need to edit to `Gamestate.new(true)` or `Gamestate.new(true, true)` respectively from within `lib/run.rb`. this defines if a player is human or computer at startup (for development, at this time).

  - Game Flow:
    - when a checker is placed into a valid column the board is checked for win conditions. this is done by pulling values from the board in four directions; ascending/descending diagonals, rows, and columns. these values are then placed into individual arrays and checked for 4 continuous values. if this is the case that player wins the game.

  - Notes:
    - computer players select random columns to place checkers for now.
    - `#checker_win` does not recognize diagonals yet. columns and rows work fine.
    - `Gamestate.rb` has too many lines and is over complicated.
    - needs intro text with human/computer players selection.
    - needs better reward for winning player.
