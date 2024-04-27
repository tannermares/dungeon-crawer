# frozen_string_literal: true

# Item has two descriptions one for looking and one for getting.
# It also contains a score that should be attributed to the player when they get it.
class Item
  attr_reader :description, :get, :name, :score

  def initialize(description:, name:, score:, get: nil)
    @description = description
    @name = name
    @score = score
    @get = get
  end

  # {
  #   name: 'scroll',
  #   score: 2,
  #   description: "Parchment, definitely parchment. I'd recognize it anywhere.",
  #   get: 'Ye takes the scroll and reads of it. It doth say: BEWARE, READER OF THE SCROLL, DANGER AWAITS TO THE- The SCROLL disappears in thy hands with ye olde ZAP!'
  # }
  def self.from_config(config)
    Item.new(
      description: config[:description],
      get: config[:get],
      name: config[:name],
      score: config[:score]
    )
  end
end
