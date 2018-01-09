class Player
  attr_accessor :name, :living_cells, :last_move

  def initialize
    @name = nil
    @living_cells = nil
    @last_move = nil
  end

  def name?(name)
    name == @name
  end
end
