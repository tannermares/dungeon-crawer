# frozen_string_literal: true

require_relative '../item'

RSpec.describe Item do
  context 'sanity checks' do
    let(:look) { 'It looketh really nice.' }
    let(:get) { 'You got it!' }
    let(:score) { 10 }
    let(:described_instance) { described_class.new(get:, look:, score:) }

    describe '#look' do
      subject { described_instance.look }
      it { is_expected.to eq look }
    end

    describe '#get' do
      subject { described_instance.get }
      it { is_expected.to eq get }
    end

    describe '#score' do
      subject { described_instance.score }
      it { is_expected.to eq score }
    end
  end
end
