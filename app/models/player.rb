# frozen_string_literal: true

# A Player has a list of items and a score based on actions and sum of their items' scores
class Player
  attr_reader :items
  attr_writer :score

  def initialize(items: [], score: 0)
    @items = items
    @score = score
  end

  def score
    @score + items.sum(&:score)
  end
end
