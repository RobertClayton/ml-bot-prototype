class Player
  attr_accessor :name, :living_cells, :last_move

  def initialize
    @name = nil
    @living_cells = nil
    @last_move = nil
  end

  # This returns true or false depending on whether or not the name parameter
  # passed is the same as the name of the player (@name)
  def name?(name)
    name == @name
  end
end
