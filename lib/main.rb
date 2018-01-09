# require "require_relative"

# require_all 'lib'

require_relative 'game/game.rb'
require_relative 'game/player.rb'
require_relative 'game/status.rb'
require_relative 'bot/bot.rb'
require_relative 'bot/engine.rb'
require_relative 'io/io.rb'

def main
  game = Game.new
  # Run opens the stream (the communication between the engine and out bot)
  game.run
end
