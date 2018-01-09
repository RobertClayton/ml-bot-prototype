class Status
  attr_reader :round, :field

  def initialize
    @round = nil
    @field = nil
  end

  def update(input, field_width)
    input.shift == 'round' ? @round = input[0] : parse_field(input[0], field_width)
    p self
  end

  private

  def parse_field(input, width)
    return if input == ''
    @field << input.slice!(0..width - 1).chars
    parse_field(input)
  end
end
