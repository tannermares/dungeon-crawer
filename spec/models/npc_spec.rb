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

  describe '.from_config' do
    let(:config) do
      {
        name: 'dennis',
        description: 'That jimberjam really makes the outfit.',
        response: 'You engage Dennis in leisurely discussion. Ye learns that his jimberjam was purchased on sale at a discount market and that he enjoys pacing about nervously. You become bored and begin thinking about parapets.',
        items: [
          {
            name: 'scroll',
            score: 2,
            description: "Parchment, definitely parchment. I'd recognize it anywhere.",
            get: 'Ye takes the scroll and reads of it. It doth say: BEWARE, READER OF THE SCROLL, DANGER AWAITS TO THE- The SCROLL disappears in thy hands with ye olde ZAP!'
          }
        ]
      }
    end

    subject { described_class.from_config(config) }

    it { expect(subject.name).to eq config[:name] }
    it { expect(subject.description).to eq config[:description] }
    it { expect(subject.response).to eq config[:response] }
    it { expect(subject.items.first).to be_instance_of(Item) }

    context 'when config does not have items' do
      let(:config) { super().except(:items) }

      it { expect { subject }.to_not raise_error }
    end
  end
end
