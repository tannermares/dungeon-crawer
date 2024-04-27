# frozen_string_literal: true

require_relative '../../app/models/item'
require_relative '../../app/models/npc'
require_relative '../../app/models/room'

RSpec.describe Room do
  let(:item) { Item.new(description: 'You like it', get: 'You got it', name: 'flask', score: 10) }
  let(:npc) { Npc.new(description: 'They looketh nice', response: 'Greetings', name: 'Dennis', items: []) }
  let(:description) { 'A big room' }
  let(:exits) { %w[south] }
  let(:name) { 'main' }
  let(:commands) { [] }
  let(:items) { [] }
  let(:npcs) { [] }

  context 'sanity checks' do
    let(:described_instance) { described_class.new(description:, exits:, name:, items:, npcs:) }

    context 'defaults' do
      let(:described_instance) { described_class.new(description:, exits:, name:) }

      describe '#items' do
        it { expect(described_instance.items).to eq [] }
      end

      describe '#npcs' do
        it { expect(described_instance.npcs).to eq [] }
      end
    end

    describe '#exits' do
      subject { described_instance.exits }

      it { is_expected.to eq exits }
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

  describe '.from_config' do
    let(:config) do
      {
        name: 'main',
        description: 'Ye find yeself in yon dungeon. Ye see a SCROLL. Behind ye scroll is a FLASK. Obvious exits are NORTH, SOUTH and DENNIS.',
        items: [
          {
            name: 'scroll',
            score: 2,
            description: "Parchment, definitely parchment. I'd recognize it anywhere.",
            get: 'Ye takes the scroll and reads of it. It doth say: BEWARE, READER OF THE SCROLL, DANGER AWAITS TO THE- The SCROLL disappears in thy hands with ye olde ZAP!'
          }
        ],
        npcs: [
          {
            name: 'dennis',
            description: 'That jimberjam really makes the outfit.',
            response: 'You engage Dennis in leisurely discussion. Ye learns that his jimberjam was purchased on sale at a discount market and that he enjoys pacing about nervously. You become bored and begin thinking about parapets.'
          }
        ],
        exits: %w[north south dennis]
      }
    end

    subject { described_class.from_config(config) }

    it { expect(subject.name).to eq config[:name] }
    it { expect(subject.description).to eq config[:description] }
    it { expect(subject.exits).to eq config[:exits] }
    it { expect(subject.items.first).to be_instance_of(Item) }
    it { expect(subject.npcs.first).to be_instance_of(Npc) }

    context 'when config does not have items' do
      let(:config) { super().except(:items) }

      it { expect { subject }.to_not raise_error }
    end

    context 'when config does not have npcs' do
      let(:config) { super().except(:npcs) }

      it { expect { subject }.to_not raise_error }
    end
  end
end
