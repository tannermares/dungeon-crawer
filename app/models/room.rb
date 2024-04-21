# frozen_string_literal: true

# A Room may have items and maybe special commands outside of normal game commands.
class Room
  attr_reader :description, :name, :decorations, :items, :npcs

  def initialize(description:, name:, decorations: [], items: [], npcs: [])
    @description = description
    @name = name
    @decorations = decorations
    @npcs = npcs
    @items = items
  end
end
