# frozen_string_literal: true

# Parser module to house all parsers.
module Parser
  # Standard game parser that handles a single command and object.
  # Single navigation input is parsed as 'go' command.
  class Standard
    def parse(input)
      tokens = input.split(' ')
      action = tokens[0]
      object = tokens[1..].join(' ')
      [action, object]
    end
  end
end