# frozen_string_literal: true

class Computer
  attr_reader :name, :color
  attr_accessor :checkers

  def initialize(name, color)
    @name = name
    @color = color
    @checkers = 21
  end

  def input_request
    input = rand(0..6) # =>  just picks a random number for now
    sleep(0.08)
    print "#{@name}'s turn => #{input + 1}"
    puts ''
    input
  end
end
