# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'

class Gamestate
  attr_reader :player1, :player2, :game_over
  attr_accessor :grid

  # grid holds 7 columns, each column holds 6 row placeholders
  def initialize(option1 = false, option2 = false)
    @turn = 1
    @grid = Array.new(7) { [] }
    @player1 = option1 == false ? Computer.new('FooBot', :white) : Player.new('Foo', :white)
    @player2 = option2 == false ? Computer.new('BarBot', :black) : Player.new('Bar', :black)
    @game_over = false
  end

  ######## Checker placment (assending order)
  def place_checker(column)
    if column.nil?
      :retry
    elsif column.size < 6
      column.push(player.color)
      checker_checker
      @turn += 1
    else
      :retry
    end
  end

  def player
    @turn.odd? ? @player1 : @player2
  end

  ######## Win Condition
  def checker_checker
    @game_over = false # no win 4 u
    # checks if all columns are full
    # checks the checkers for checker wins
  end

  ######## Game Controls

  def game_reset
    @grid = Array.new(7) { [] }
    @player1.checkers = 21
    @player2.checkers = 21
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
