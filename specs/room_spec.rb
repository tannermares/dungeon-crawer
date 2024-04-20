# frozen_string_literal: true

require_relative '../command'
require_relative '../item'
require_relative '../room'

RSpec.describe Room do
  let(:command) { Command.new }
  let(:item) { Item.new(get: 'You got it', look: 'You like it', score: 10) }

  context 'sanity checks' do
    let(:described_instance) { described_class.new(commands:, items:) }

    context 'defaults' do
      let(:described_instance) { described_class.new }

      describe '#commands' do
        it { expect(described_instance.commands).to eq [] }
      end

      describe '#items' do
        it { expect(described_instance.items).to eq [] }
      end
    end

    describe '#commands' do
      let(:commands) { [command] }
      let(:items) { [] }

      subject { described_instance.commands }

      it { is_expected.to eq commands }
    end

    describe '#items' do
      let(:commands) { [] }
      let(:items) { [item] }

      subject { described_instance.items }

      it { is_expected.to eq items }
    end
  end
end
