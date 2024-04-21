# frozen_string_literal: true

require_relative '../../app/models/item'
require_relative '../../app/models/npc'
require_relative '../../app/models/room'

RSpec.describe Room do
  let(:item) { Item.new(description: 'You like it', get: 'You got it', name: 'flask', score: 10) }
  let(:npc) { Npc.new(description: 'They looketh nice', response: 'Greetings', name: 'Dennis', items: []) }
  let(:description) { 'A big room' }
  let(:name) { 'main' }
  let(:commands) { [] }
  let(:items) { [] }
  let(:npcs) { [] }

  context 'sanity checks' do
    let(:described_instance) { described_class.new(description:, items:, name:, npcs:) }

    context 'defaults' do
      let(:described_instance) { described_class.new(description:, name:) }

      describe '#items' do
        it { expect(described_instance.items).to eq [] }
      end

      describe '#npcs' do
        it { expect(described_instance.npcs).to eq [] }
      end
    end

    describe '#items' do
      let(:items) { [item] }

      subject { described_instance.items }

      it { is_expected.to eq items }
    end

    describe '#npcs' do
      let(:npcs) { [npc] }

      subject { described_instance.npcs }

      it { is_expected.to eq npcs }
    end
  end
end
