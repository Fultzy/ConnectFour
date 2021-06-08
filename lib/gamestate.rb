# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'

class Gamestate
  attr_reader :player1, :player2, :game_over
  attr_accessor :grid

  def initialize(option1 = false, option2 = false)
    @turn = 1
    @grid = Array.new(7) { [] }
    @player1 = option1 == false ? Computer.new('FooBot', :white) : Player.new('Foo', :white)
    @player2 = option2 == false ? Computer.new('BarBot', :black) : Player.new('Bar', :black)
    @game_over = false
  end

  #### Checker placment (vertical order like irl)
  def place_checker(column)
    if column.size < 6
      column.push(player.color)
      checker_checker
      checker_win(column)
      player.checkers -= 1
      @turn += 1
    else
      :retry
    end
  end

  def player
    @turn.odd? ? @player1 : @player2
  end

  # checks players checkers for lack of checkers
  def checker_checker
    if @player1.checkers == 0 || @player2.checkers == 0
      game_over = true
    end
  end

  #### Win Conditions ( this should be a Class )
  def checker_win(column)
    color = player.color
    col_index = column.size - 1
    row = create_row_array(col_index)
    # ascending = create_ascending_array(column, col_index)
    # descending = create_descending_array(column, col_index)
  # => vertical
    if four_in_a_row?(column)
      @game_over = true
      puts "Column: #{column}"
      player
  # => horizontal
    elsif four_in_a_row?(row)
      @game_over = true
      puts "Row: #{row}"
      player
    end
  end
=begin
  # => ascending
    elsif four_in_a_row?(ascending)
      @game_over = true
      puts "Ascending: #{ascending}"
      player.wins
  # => descending
    elsif four_in_a_row?(descending)
      @game_over = true
      puts "Descending: #{descending}"
      player.wins
=end

  def four_in_a_row?(array, count = 0, i = 0, last_elm = nil)
    unless array[i].nil? || i > array.size
      array[i + 1] == array[i] ? count += 1 : last_elm = array[i + 1] && count = 0
      count == 4 ? true : four_in_a_row?(array, count, i += 1, last_elm)
    end
  end

  #### Directional Arrays
  def create_row_array(row, col = 0, array = [])
    unless col > 6
      array.push(@grid[col][row])
      create_row_array(row, col + 1, array)
      array
    end
  end

  def create_ascending_array(col, row, array = [])
    while col > 0 || row < 7
      array.push(@grid[col][row])
      create_ascending_array(col - 1, row + 1, array)
      create_ascending_array(col + 1, row - 1, array)
      array
    end
  end

  def create_descending_array(col, row, array = [])
    unless col.nil? || row.nil?
      array.push(@grid[col][row])
      create_ascending_array(col + 1, row - 1 , array)
      create_ascending_array(col - 1, row + 1, array)
      array
    end
  end
  #### Game Controls
  def game_reset
    initialize
  end

  def request_replay?
  end

  def grid_view
    puts ''
    print_grid
    puts ''
    puts '-----------------------------------'
    puts '  1    2    3    4    5    6    7'
  end

  def print_grid(col = 0, row = 5)
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
        print_grid(0, row -= 1)
      else
        print_grid(col + 1, row)
      end
    end
  end
end
