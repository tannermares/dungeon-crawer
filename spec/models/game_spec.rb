# frozen_string_literal: true

require_relative '../../app/models/game'

RSpec.describe Game do
  describe '#start' do
    subject { described_instance.start }
    it { expect(described_instance.player).to_not be_nil }
  end

  describe '.from_config' do
    subject { described_class.from_config(config) }
    it { is_expected.to be_instance_of(Game) }
  end

  describe '.play' do
    subject { described_class.play }
    after { subject }

    it { expect(described_class).to receive(:from_config).with(Game::Config::THY_DUNGEONMAN) }
    it { expect_any_instance_of(described_class).to receive(:start) }
  end
end
