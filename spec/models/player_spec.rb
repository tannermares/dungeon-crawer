# frozen_string_literal: true

require_relative '../../app/models/item'
require_relative '../../app/models/player'

RSpec.describe Player do
  let(:item) { Item.new(description: 'You like it', get: 'You got it', name: 'flask' , score: 10) }

  context 'sanity checks' do
    let(:described_instance) { described_class.new(items:) }

    context 'defaults' do
      let(:described_instance) { described_class.new }

      describe '#items' do
        it { expect(described_instance.items).to eq [] }
      end

      describe '#score' do
        it { expect(described_instance.score).to eq 0 }
      end
    end

    describe '#items' do
      let(:items) { [item] }

      subject { described_instance.items }

      it { is_expected.to eq items }
    end
  end

  describe '#score' do
    let(:described_instance) { described_class.new(items:, score:) }

    subject { described_instance.score }

    context 'when player has no score but has items' do
      let(:score) { 0 }
      let(:items) { [item, item] }
      it { is_expected.to be items.sum(&:score) }
    end

    context 'when player has no items but has score' do
      let(:score) { 10 }
      let(:items) { [] }
      it { is_expected.to be score }
    end

    context 'when player has no score nor items' do
      let(:score) { 0 }
      let(:items) { [] }
      it { is_expected.to be 0 }
    end
  end
end
