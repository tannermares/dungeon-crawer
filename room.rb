# frozen_string_literal: true

# A Room may have items and maybe special commands outside of normal game commands.
class Room
  attr_reader :commands, :items

  def initialize(commands: [], items: [])
    @commands = commands
    @items = items
  end
end
