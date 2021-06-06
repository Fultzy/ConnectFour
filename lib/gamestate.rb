# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'

class Gamestate
  attr_reader :player1, :player2, :game_over
  attr_accessor :grid

  # grid holds 7 columns(empty arrays, max size == 6)
  def initialize(option1 = false, option2 = false)
    @turn = 1
    @grid = Array.new(7) { [] }
    @player1 = option1 == false ? Computer.new('FooBot', :white) : Player.new('Foo', :white)
    @player2 = option2 == false ? Computer.new('BarBot', :black) : Player.new('Bar', :black)
    @game_over = false
  end

  ######## Checker placment (assending order like irl)
  def place_checker(column)
    if column.size < 6
      column.push(player.color)
      checker_checker
      # checker_win(column)
      @turn += 1
    else
      :retry
    end
  end

  def player
    @turn.odd? ? @player1 : @player2
  end

  ######## Win Conditions
  # checks players checkers for lack of checkers
  def checker_checker
    if @player1.checkers == 0 || @player2.checkers == 0
      game_over = true
    end
  end

  # pulls from @grid (targetting the last value in column) adds to arrays
  # if any array includes 4 checkers in a row from a single player
  def checker_win(column)
    color = player.color
    col_index = column.size - 1
    row = create_row_array(col_index)
    ascending = create_ascending_array(column, col_index)
    descending = create_descending_array(column, col_index)
    case @game_over
  # => horizontal
    when row <=> [color, color, color, color]
      player

  # => vertical
    when "banana"
      #player.wins

  # => diaginal ascending
    when "potato"
      #player.wins

  # => descending
    when "grapes"
      #player.wins

    else
      nil
    end
  end

  #### Array Creation ####
  def create_row_array(row, col = -1, array = [])
    unless col > 6
      array.push(@grid[col += 1][row])
      create_row_array(row, col, array)
    end
  end

  def create_ascending_array(col,row)
  end

  def create_descending_array(col,row)
  end



  def request_replay?
  end

  ######## Game Controls
  def game_reset
    initialize
  end

  def show_grid(col = 0, row = 5)
    case @grid[col][row]
    when :white
      print '| 0 |'
    when :black
      print '| x |'
    when nil
      print '|   |'
    end
    unless row.zero? && col == 6
      if col == 6
        puts ''
        show_grid(0, row -= 1)
      else
        show_grid(col + 1, row)
      end
    end
  end
end
