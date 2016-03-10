require 'journeylog'

describe Journeylog do
  let(:journey) { double(:Journey, start: nil) }
  let(:journey_class) { double(:Journey_class, new: journey) }
  subject(:log) { described_class.new(journey_klass: journey_class) }
  let(:station) { double(:Station) }

  describe '#start' do
    it 'gives journey an entry station' do
      expect(journey).to receive(:start).with(station)
      log.start(station)
    end

    it 'ends previous journey if already in one' do
      log.start(station)
      expect(log).to receive(:finish).with(:penalty)
      log.start(station)
    end
  end

  describe '#finish' do

  end

  describe '#fare' do

  end
end
