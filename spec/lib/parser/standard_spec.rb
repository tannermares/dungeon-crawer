# frozen_string_literal: true

require_relative '../../../app/lib/parser/standard'

RSpec.describe Parser::Standard do
  let(:described_instance) { described_class.new }

  describe '#parse' do
    subject { described_instance.parse(input) }

    context 'with separate commands' do
      let(:input) { 'go north' }
      it { is_expected.to eq %w[go north] }

      context 'that should be single command' do
        let(:input) { 'not dennis' }
        it { is_expected.to eq ['not dennis', ''] }
      end
    end

    context 'with single command' do
      let(:input) { 'north' }
      it { is_expected.to eq ['north', ''] }
    end
  end
end
