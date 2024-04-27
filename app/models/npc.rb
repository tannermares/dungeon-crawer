# frozen_string_literal: true

# An Npc is an object that has items can respond to "talk" and has a description
class Npc
  attr_accessor :description, :name, :response, :items

  def initialize(description:, name:, response:, items: [])
    @description = description
    @name = name
    @response = response
    @items = items
  end

  # {
  #   name: 'dennis',
  #   description: 'That jimberjam really makes the outfit.',
  #   response: 'You engage Dennis in leisurely discussion. Ye learns that his jimberjam was purchased on sale at a discount market and that he enjoys pacing about nervously. You become bored and begin thinking about parapets.',
  #   items: []
  # }
  def self.from_config(config)
    npc = Npc.new(description: config[:description], name: config[:name], response: config[:response])

    npc.items = config[:items]&.map { |item| Item.from_config(item) }
    npc
  end
end
