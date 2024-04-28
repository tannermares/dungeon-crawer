# frozen_string_literal: true

# Parser module to house all parsers.
module Parser
  # Standard game parser that handles a single command and object.
  # Single navigation input is parsed as 'go' command.
  class Standard
    def parse(input)
      tokens = input.split(' ')
      action = tokens[0].downcase.to_sym
      object = tokens[1..].join(' ').downcase
      [action, object.empty? ? nil : object]
    end
  end
end