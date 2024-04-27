# frozen_string_literal: true

require_relative 'app/models/game'

game = Game.start
game.play while game.playing?
