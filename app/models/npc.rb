# frozen_string_literal: true

# An Npc is an object that has items can respond to "talk" and has a description
class Npc
  attr_reader :description, :name, :response, :items

  def initialize(description:, name:, response:, items: [])
    @description = description
    @name = name
    @response = response
    @items = items
  end
end
