# frozen_string_literal: true

require_relative '../../app/lib/parser/standard'
require_relative '../../app/models/room'
require_relative '../../app/models/player'

# A Game in in charge of building Rooms, and a Player to play the game.
# It takes a config that describes the game to be played.
class Game
  attr_accessor :config, :input, :player, :rooms

  def initialize(config:, player: Player.new)
    @config = config
    @player = player

    @current_room = config[:start]
    @input = nil
    @introed = false
  end

  def intro
    @introed = true
    config[:intro]
  end

  def introed?
    @introed
  end

  def parse
    action, object = parser.parse(input)
    return unless action

    send(action, object)
  rescue NoMethodError
    puts config[:error]
  end

  def parser
    @parser ||= Object.const_get("Parser::#{config[:parser].capitalize}").new
  end

  def play
    print intro unless introed?
    print prompt
    @input = gets.chomp
    return if input == 'exit'

    parse
  end

  def playing?
    input != 'exit'
  end

  def prompt
    "\n#{config[:prompt]} (score: #{player.score})\n> " # Trailing space is intentional
  end

  def self.from_config(config)
    game = Game.new(config:)

    config[:actions]&.each do |action, object|
      define_method(action) do |_ = nil|
        player.score += object[:score]
        puts object[:result]
      end
    end

    game.rooms = config[:rooms]&.map { |room| Room.from_config(room) }
    game
  end

  def self.start(config: Config::THY_DUNGEONMAN)
    from_config(config)
  end

  class Config
    THY_DUNGEONMAN = {
      error: 'That does not computeth. Type HELP is thou needs of it.',
      parser: 'standard',
      intro: "THY DUNGEONMAN\n\nYOU ARE THY DUNGEONMAN!\n\n",
      prompt: 'What wouldst thou deau?',
      start: [0, 0],
      items: [
        {
          name: 'dagger',
          count: 999,
          score: 25,
          result: 'Yeah, okay.'
        }
      ],
      actions: {
        dance: {
          score: 0,
          result: 'Thou shaketh it a little, and it feeleth all right.'
        },
        die: {
          score: -100,
          result: "That wasn't very smart. Your score was: {{player.score}}. Play again? [Y/N]"
        },
        smell: {
          score: 0,
          result: 'You smell a Wumpus.'
        },
        sniff: {
          score: 0,
          result: 'You smell a Wumpus.'
        }
        # get: {
        #   dagger: {
        #     score: 25,
        #     result: 'Yeah, okay.'
        # }
      },
      rooms: [
        {
          coord: [0, 0],
          name: 'not dennis',
          description: 'Ye find yeself in yon dungeon. Ye see a SCROLL. Behind ye scroll is a FLASK. Obvious exits are NORTH, SOUTH and DENNIS.',
          # actions: {
          #   look: {
          #     default: 'Ye find yeself in yon dungeon. Ye see a SCROLL. Behind ye scroll is a FLASK. Obvious exits are NORTH, SOUTH and DENNIS.',
          #     scroll: "Parchment, definitely parchment. I'd recognize it anywhere."
          #   },
          #   get: {
          #     scroll: {
          #       score: 2,
          #       result: "Ye takes the scroll and reads of it. It doth say: BEWARE, READER OF THE SCROLL, DANGER AWAITS TO THE- The SCROLL disappears in thy hands with ye olde ZAP!"
          #     }
          #   }
          # },
          items: [
            {
              name: 'scroll',
              score: 2,
              description: "Parchment, definitely parchment. I'd recognize it anywhere.",
              get: 'Ye takes the scroll and reads of it. It doth say: BEWARE, READER OF THE SCROLL, DANGER AWAITS TO THE- The SCROLL disappears in thy hands with ye olde ZAP!'
            },
            {
              name: 'scroll',
              score: -1,
              description: 'Ye seeth nothing wheretofore it went ZAP.',
              get: 'Ye doth suffer from memory loss. YE SCROLL is no more. Honestly.'
            },
            {
              name: 'flask',
              score: 1,
              description: 'Looks like you could quaff some serious mead out of that thing.',
              get: 'Ye cannot get the FLASK. It is firmly bolted to a wall which is bolted to the rest of the dungeon which is probably bolted to a castle. Never you mind.'
            },
            {
              name: 'flask',
              score: 1,
              description: 'Looks like you could quaff some serious mead out of that thing.',
              get: 'Ye cannot get the FLASK. It is firmly bolted to a wall which is bolted to the rest of the dungeon which is probably bolted to a castle. Never you mind.'
            },
            {
              name: 'flask',
              score: -1000,
              description: 'Looks like you could quaff some serious mead out of that thing.',
              get: 'Okay, okay. You unbolt yon FLASK and hold it aloft. A great shaking begins. The dungeon ceiling collapses down on you, crushing you in twain. Apparently, this was a load-bearing FLASK. Your score was: ___ Play again? [Y/N]'
            }
          ],
          npcs: [],
          exits: %w[north south dennis]
        },
        {
          coord: [0, 1],
          name: 'north',
          description: 'You go NORTH through yon corrider. You arrive at parapets. Ye see a rope. Obvious exits are SOUTH.',
          items: [
            {
              name: 'rope',
              score: -1,
              description: "It looks okay. You've seen better.",
              get: 'You attempt to take ye ROPE but alas it is enchanted! It glows a mustard red and smells like a public privy. The ROPE wraps round your neck and hangs you from parapets. With your last breath, you wonder what parapets are. GAME OVER. Your score was:__. Play again? (Y/N)'
            },
            {
              name: 'parapets',
              description: "Well, they're parapets. This much we know for sure."
            }
          ],
          npcs: [],
          exits: %w[south]
        },
        {
          coord: [0, -1],
          name: 'south',
          description: "You head south to an enbankment. Or maybe a chasm. You can't decide which. Anyway, ye spies a TRINKET. Obvious exits are NORTH.",
          items: [
            {
              name: 'trinket',
              score: 2,
              description: 'Quit looking! Just get it already.',
              get: 'Ye getsts yon TRINKET and discover it to be a bauble. You rejoice at your good fortune. You shove the TRINKET in your pouchel. It kinda hurts.'
            },
            {
              name: 'trinket',
              score: -1,
              description: 'Just a bulge in thou pouchel at thist point.',
              get: 'Sigh. The trinket is in thou pouchel. Recallest thou?'
            }
          ],
          npcs: [],
          exits: %w[north]
        },
        {
          coord: [1, 0],
          name: 'dennis',
          description: 'Ye arrive at Dennis. He wears a sporty frock coat and a long jimberjam. He paces about nervously. Obvious exits are NOT DENNIS.',
          items: [],
          npcs: [
            {
              name: 'dennis',
              description: 'That jimberjam really makes the outfit.',
              response: 'You engage Dennis in leisurely discussion. Ye learns that his jimberjam was purchased on sale at a discount market and that he enjoys pacing about nervously. You become bored and begin thinking about parapets.',
              items: [
                {
                  name: 'jimberjam',
                  description: 'Man, that art a nice jimberjam.'
                }
              ]
            }
          ],
          exits: ['not dennis']
        }
      ]
    }.freeze
  end
end
