# frozen_string_literal: true

require_relative '../../app/models/item'

RSpec.describe Item do
  context 'sanity checks' do
    let(:description) { 'It looketh really nice.' }
    let(:get) { 'You got it!' }
    let(:name) { 'flask' }
    let(:score) { 10 }
    let(:described_instance) { described_class.new(description:, get:, name:, score:) }

    describe '#description' do
      subject { described_instance.description }
      it { is_expected.to eq description }
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
