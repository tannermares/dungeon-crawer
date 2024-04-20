# frozen_string_literal: true

# Item has two descriptions one for looking and one for getting.
# It also contains a score that should be attributed to the player when they get it.
class Item
  attr_reader :get, :look, :score

  def initialize(get:, look:, score:)
    @get = get
    @look = look
    @score = score
  end
end
