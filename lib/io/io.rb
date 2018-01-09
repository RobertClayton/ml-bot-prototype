class Io
  class << self
    def get
      input = gets.chomp
      # recursion on Get! Keeps looping until an input is given, like a listener
      get if input.length == 0
      # Ends listening on input: 'quit'
      Process.exit!(true) if input == 'quit'
      # Turns nested arrays into a 1D array
      return input.gsub(/[\[\]\,]/, '').split(' ')
    end

    def post(output)
      p output
    end
  end
end
