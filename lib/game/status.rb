class Status
  attr_reader :round, :field

  def initialize
    @round = nil
    @field = nil
  end

  # This method will be called from the Game class' update method.
  # 'update game [TYPE] [VALUE]' will be inputted to the stream
  # Here, [TYPE] is the value passed to input, and [VALUE] is the value passed
  # field_width (which comes from the Game's @settings instance variable hash)
  def update(input, field_width)
    # If [TYPE] is round, then Status' @round property will be set to [VALUE]
    # If [TYPE] is not round (i.e. field), then the parse_field method is called
    # with the word field and [VALUE], which is an array
    input.shift == 'round' ? @round = input[0] : parse_field(input[0], field_width)
    # This prints out the current Status object
    p self
  end

  private

  # This is a private method, called from the update method
  # It is responsible for creating/updating the field in a machine-readable format
  def parse_field(input, width)
    # If input is nothing, return
    # This is an exit clause to prevent this recursive method running infinitely
    return if input == ''
    # This appends a new array of the width of the board to the @field instance
    # variable; as the method runs, this buils up into a 2D array
    @field << input.slice!(0..width - 1).chars
    # This will continue to recursively call the parse_field method until the
    # entire board has been parsed; the output will be that @field is set to be
    # a 2D array
    parse_field(input)
  end
end
