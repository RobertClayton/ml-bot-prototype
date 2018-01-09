class Bot
  def initialize
    @engine = Engine.new
  end

  # Field is the Game's @status object, which is an instance of the Status class
  # Time is an integer, representing the number of milliseconds we have to make
  # the move
  # This method is where the strategy for the bot is going to take place
  def play(field, time)
    return 'Random Winning Move'
  end
end
