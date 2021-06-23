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
      player.checkers -= 1
    else
      :retry
    end
  end

  #### Four in a Row????
  def four_in_a_row?(array, count = 1, index = 0)
    return true if count == 4
    return false if array.nil? || index > array.size || array.size < 4

    if array[index].nil? || array[index] != array[index + 1]
      four_in_a_row?(array, 1, index + 1)
    elsif array[index + 1] == array[index]
      four_in_a_row?(array, count + 1, index + 1)
    end
  end

  #### Win Conditions
  def checker_win(input)
    col_index = @grid[input].size - 1
    row = create_row_array(col_index)
    ascending = create_ascending_array(input, col_index)
    descending = create_descending_array(input, col_index)

    if four_in_a_row?(ascending) || four_in_a_row?(descending) || four_in_a_row?(@grid[input]) || four_in_a_row?(row)
      @game_over = true
      # player.wins
    else
      false
    end
  end

  #### Directional Arrays
  def create_row_array(row, col = 0, array = [])
    return if col > 6

    array.push(@grid[col][row])
    create_row_array(row, col + 1, array)
    array
  end

  def create_ascending_array(col, row, array = [])
    return array if col > 6 || row > 5

    if array.empty?
      if col > row
        array.push(@grid[col - row][0])
        create_ascending_array(col - row + 1, 1, array)
      else
        array.push(@grid[0][row - col])
        create_ascending_array(1, row - col + 1, array)
      end
    else
      array.push(@grid[col][row])
      create_ascending_array(col + 1, row + 1, array)
    end
  end

  def create_descending_array(col, row, array = [])

  end

  #### Game Controls
  def player
    @turn.odd? ? @player1 : @player2
  end

  def turn
    grid_view
    input = player.input_request
    place_checker(@grid[input])
    checker_win(input)
    checker_checker
    @turn += 1
  end

  def game_reset
    initialize
  end

  def checker_checker
    game_over = true if @player1.checkers.zero? || @player2.checkers.zero?
  end

  def request_replay; end

  def grid_view
    puts ''
    printy_gridy
    puts ''
    puts '-----------------------------------'
    puts '  1    2    3    4    5    6    7'
    puts "#{player.name} checkers left: #{player.checkers}"
  end

  def printy_gridy(col = 0, row = 5)
    case @grid[col][row]
    when :white
      print '| 0 |'
    when :black
      print '| x |'
    when nil
      print '|   |'
    end
    return if row.zero? && col == 6

    if col == 6
      puts ''
      printy_gridy(0, row -= 1)
    else
      printy_gridy(col + 1, row)
    end
  end
end
