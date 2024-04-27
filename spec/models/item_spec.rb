# frozen_string_literal: true

require_relative '../../app/models/item'

RSpec.describe Item do
  context 'sanity checks' do
    let(:description) { 'It looketh really nice.' }
    let(:get) { 'You got it!' }
    let(:name) { 'flask' }
    let(:score) { 10 }
    let(:described_instance) { described_class.new(description:, get:, name:, score:) }

    context 'defaults' do
      let(:described_instance) { described_class.new(description:, name:, score:) }

      describe '#get' do
        it { expect(described_instance.get).to eq nil }
      end
    end

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

  describe '.from_config' do
    let(:config) do
      {
        name: 'scroll',
        score: 2,
        description: "Parchment, definitely parchment. I'd recognize it anywhere.",
        get: 'Ye takes the scroll and reads of it. It doth say: BEWARE, READER OF THE SCROLL, DANGER AWAITS TO THE- The SCROLL disappears in thy hands with ye olde ZAP!'
      }
    end

    subject { described_class.from_config(config) }

    it { expect(subject.name).to eq config[:name] }
    it { expect(subject.description).to eq config[:description] }
    it { expect(subject.score).to eq config[:score] }
  end
end
