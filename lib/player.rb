# frozen_string_literal: true

class Player
  attr_reader :name, :color
  attr_accessor :checkers

  def initialize(name, color)
    @name = name
    @color = color
    @checkers = 21
  end

  def input_request
    puts 'Enter a number'
    print "#{@name}'s turn =>"
    gets.chomp.to_i - 1
  end
end
