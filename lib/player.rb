
class Player
  attr_reader :name, :color, :checkers
  def initialize(name, color)
    @name = name
    @color = color
    @checkers = 21
  end
end
