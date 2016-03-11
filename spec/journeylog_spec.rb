require 'journeylog'

describe Journeylog do
  let(:journey) { double(:Journey, start: nil, finish: nil) }
  let(:journey_class) { double(:Journey_class, new: journey) }
  subject(:log) { described_class.new(journey_class: journey_class) }
  let(:station) { double(:Station) }

  describe '#start' do
    it 'gives journey an entry station' do
      expect(journey).to receive(:start).with(station)
      log.start(station)
    end

    it 'ends previous journey if already in one' do
      log.start(station)
      expect(log).to receive(:finish).with(:nil)
      log.start(station)
    end
  end

  describe '#finish' do
    it 'gives journey an exit station' do
      expect(journey).to receive(:finish).with(station)
      log.finish(station)
    end

    it 'logs the finished journey' do
      log.start(station)
      log.finish(station)
      expect(log.journeys).not_to be_empty
    end
  end

  describe '#journeys' do
    it 'returns a copy of the protected journeys array' do
      allow(log).to receive(:journeys){[journey]}
      log.journeys << 1
      expect(log.journeys).to eq [journey]
    end
  end
end
