# frozen_string_literal: true

require_relative '../../app/models/item'
require_relative '../../app/models/npc'

# A Room may have items and maybe special commands outside of normal game commands.
class Room
  attr_accessor :description, :exits, :name, :items, :npcs

  def initialize(description:, exits:, name:, items: [], npcs: [])
    @description = description
    @exits = exits
    @name = name
    @npcs = npcs
    @items = items
  end

  #  {
  #   name: 'main',
  #   description: 'Ye find yeself in yon dungeon. Ye see a SCROLL. Behind ye scroll is a FLASK. Obvious exits are NORTH, SOUTH and DENNIS.',
  #   items: [
  #     {
  #       name: 'scroll',
  #       score: 2,
  #       description: "Parchment, definitely parchment. I'd recognize it anywhere.",
  #       get: 'Ye takes the scroll and reads of it. It doth say: BEWARE, READER OF THE SCROLL, DANGER AWAITS TO THE- The SCROLL disappears in thy hands with ye olde ZAP!'
  #     },
  #   ],
  #   npcs: [],
  #   exits: %w[north south dennis]
  # }
  def self.from_config(config)
    room = Room.new(
      description: config[:description],
      exits: config[:exits],
      name: config[:name]
    )

    room.items = config[:items]&.map { |item| Item.from_config(item) }
    room.npcs = config[:npcs]&.map { |npc| Npc.from_config(npc) }
    room
  end
end
