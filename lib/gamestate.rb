
require_relative 'player.rb'
require_relative 'computer.rb'

class Gamestate
  attr_reader :player1, :player2
  attr_accessor :grid

  # grid holds 7 columns, each column holds 6 row values
  def initialize(option1 = false, option2 = false)
    @turn = 1
    @grid = Array.new(7) { Array.new(6) }
    @player1 = option1 == false ? Computer.new('FooBot', :white) : Player.new('Foo', :white)
    @player2 = option2 == false ? Computer.new('BarBot', :Black) : Player.new('Bar', :black)

  end

  def place_checker(column)
    if column.empty?
      column[0] = player
    else
      # walk array until target is nil
    end

  end

  def checker_checker
    #checks the checkers for checkers
  end


end
