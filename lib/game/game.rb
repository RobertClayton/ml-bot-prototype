class Game
  def initialize
    # Initialize with Engine.new
    # Engine is currently empty
    @bot = Bot.new
    @settings = {}
    # Initialize with @round & @field - they are flasey
    @status = Status.new
    # Initialize with @name, @living_cells, @last_move - set to nil
    @me = Player.new
    @opponent = Player.new
  end

  def run
    # Listens for input, which will be data in the form of a Multidimensional
    # Array, and converts into a 1D array
    input = Io.get
    # .send runs the first command in the input array
    # if that command is not recognised it returns 'Invalid Instruction'
    self.send(input.shift, input) || 'Invalid Instruction'
  end

  # These private methods are only accessible once inside the stream
  # These can be executed with the commands found here:
  # https://docs.riddles.io/game-of-life-and-death/api
  private

  # Given only at the start of the game. Contains a game setting
  # e.g. settings [type] [value]
  #   ( settings timebank 1000 = {:timebank=>"1000"})
  def settings(input)
    # if the command is called player_names' add_players
    # add_players assigns the name to @me and @opponent; then executes Run
    add_players(input) if input[0] == 'player_names'
    # Either adds a new Key/Value pair or updates the Value of an exisiting Key
    @settings[input[0].to_sym] = input[1]
    p @settings
    # Continues listening for the next command (in the IO stream)
    run
  end

  # This is an update of the game state.
  # e.g. update [player] [type] [value]
  #   ( update game round i = #<Status:0x007fd6d7b61178 @round="1", @field=nil>)
  # [player] indicates what bot the update is about,
  # but could also be game to indicate a general update.
  def update(input)
    # checks whether updating game or player
    # if game, passes into status.update
    #   (drop the first element (which will be the word game) so we are left with just the update (type, value) ,
    #   field_width is the amount of columns)
    input[0] == 'game' ? @status.update(input.drop(1), @settings[:field_width]) : update_players(input)
    # Continues listening for the next command (in the IO stream)
    run
  end

  # Indicates a request for an action.
  # The time your bot has to respond is given in milliseconds.
  def action(input)
    action = @bot.play(@status, input.last)
    Io.post(action)
    run
  end

  def add_players(names)
    @me.name = names[1]
    @opponent.name = names[2]
    p @me, @opponent
    run
  end

  def update_players(input)
    return update_player(@me, input) if @me.name?(input.shift)
    update_player(@opponent, input)
  end

  def update_player(player, input)
    input.shift == 'move' ? player.last_move = input.join : player.living_cells = input.join
    p player
  end
end
