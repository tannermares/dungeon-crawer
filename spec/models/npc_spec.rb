# frozen_string_literal: true

require_relative '../../app/models/item'
require_relative '../../app/models/npc'

RSpec.describe Npc do
  let(:item) { Item.new(description: 'You like it', get: 'You got it', name: 'flask', score: 10) }
  let(:items) { [] }
  let(:description) { 'They look nice' }
  let(:name) { 'Dennis' }
  let(:response) { 'Yo dawg' }

  context 'sanity checks' do
    let(:described_instance) { described_class.new(description:, items:, name:, response:) }

    context 'defaults' do
      let(:described_instance) { described_class.new(description:, name:, response:) }

      describe '#items' do
        it { expect(described_instance.items).to eq [] }
      end
    end

    describe '#description' do
      subject { described_instance.description }

      it { is_expected.to eq description }
    end

    describe '#items' do
      let(:items) { [item] }

      subject { described_instance.items }

      it { is_expected.to eq items }
    end

    describe '#response' do
      subject { described_instance.response }

      it { is_expected.to eq response }
    end
  end
end