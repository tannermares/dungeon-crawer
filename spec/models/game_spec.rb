# frozen_string_literal: true

require_relative '../../app/models/game'

RSpec.describe Game do
  let(:config) { Game::Config::THY_DUNGEONMAN }
  let(:described_instance) { described_class.from_config(config) }

  describe '.from_config' do
    subject { described_class.from_config(config) }
    it { is_expected.to be_instance_of(Game) }

    context 'actions' do
      it { expect { subject.dance }.to_not raise_error }
    end
  end

  describe '.start' do
    subject { described_class.start(config:) }
    after { subject }
    it { expect(described_class).to receive(:from_config).with(config) }
  end

  describe '#intro' do
    subject { described_instance.intro }

    it { is_expected.to eq config[:intro] }
    it { expect { subject }.to change { described_instance.introed? }.from(false).to(true) }
  end

  describe '#introed?' do
    subject { described_instance.introed? }

    context 'when intro not called' do
      it { is_expected.to eq false }
    end

    context 'when intro called' do
      before { described_instance.intro }
      it { is_expected.to eq true }
    end
  end

  describe '#parse' do
    subject { described_instance.parse }
    after { subject }

    before { described_instance.input = input }

    context 'with empty input' do
      let(:input) { nil }
      it { expect(described_instance).to receive_message_chain(:parser, :parse).with(input) }
    end

    context 'with some input' do
      context 'with separate commands' do
        let(:input) { 'go north' }
        it { expect(described_instance).to receive_message_chain(:parser, :parse).with(input) }
        it { expect(described_instance).to receive('go').with('north') }
      end

      context 'with single commands' do
        let(:input) { 'north' }
        it { expect(described_instance).to receive_message_chain(:parser, :parse).with(input) }
        it { expect(described_instance).to receive('north') }
      end
    end
  end

  describe '#parser' do
    before { expect(described_instance).to receive(:config).and_return({ parser: }) }
    subject { described_instance.parser }

    context 'when parser exists' do
      let(:parser) { 'standard' }

      it { expect { subject }.to_not raise_error }
      it { is_expected.to be_instance_of(Parser::Standard) }

      context 'handles any casing' do
        let(:parser) { 'STANDARD' }

        it { expect { subject }.to_not raise_error }
        it { is_expected.to be_instance_of(Parser::Standard) }
      end
    end

    context 'when parser does not exist' do
      let(:parser) { 'complex' }

      it { expect { subject }.to raise_error(NameError, 'uninitialized constant Parser::Complex') }
    end
  end

  describe '#play' do
    subject { described_instance.play }

    after { subject }

    context 'when not already introed' do
      before do
        expect(described_instance).to receive(:introed?).and_return(false)
        expect(described_instance).to receive(:print).with(described_instance.intro)
        expect(described_instance).to receive(:print).with(described_instance.prompt)
        expect(described_instance).to receive(:gets).and_return('dance')
      end

      it { expect { subject }.to change { described_instance.input }.from(nil).to('dance') }
      it { expect(described_instance).to receive(:parse) }
    end

    context 'when already introed' do
      before do
        expect(described_instance).to receive(:introed?).and_return(true)
        expect(described_instance).to receive(:print).with(described_instance.prompt)
        expect(described_instance).to receive(:gets).and_return('dance')
      end

      it { expect { subject }.to change { described_instance.input }.from(nil).to('dance') }
      it { expect(described_instance).to receive(:parse) }
    end
  end

  describe '#playing?' do
    before { described_instance.input = input }

    subject { described_instance.playing? }

    context 'when input equals exit' do
      let(:input) { 'exit' }
      it { is_expected.not_to be }
    end

    context 'when input does not equal exit' do
      let(:input) { 'go north' }
      it { is_expected.to be }
    end
  end

  describe '#prompt' do
    before { expect(described_instance).to receive(:config).and_return(config) }

    subject { described_instance.prompt }

    context 'when config includes a prompt' do
      let(:config) { { prompt: 'What we doin?' } }

      it { is_expected.to eq "\nWhat we doin? (score: 0)\n> " }
    end

    context 'when config does not include a prompt' do
      let(:config) { {} }

      it { is_expected.to eq "\n (score: 0)\n> " }
    end
  end
end
