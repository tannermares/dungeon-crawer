# frozen_string_literal: true

# Item has two descriptions one for looking and one for getting.
# It also contains a score that should be attributed to the player when they get it.
class Item
  attr_reader :description, :get, :name, :score

  def initialize(description:, get:, name:, score:)
    @description = description
    @get = get
    @name = name
    @score = score
  end
end
