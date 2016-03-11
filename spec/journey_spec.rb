require 'journey'

describe Journey do
  penalty_fare = Journey::PENALTY_FARE
  min_fare = Journey::MIN_FARE
  let(:station){ double(:station, zone: 1)}
  let(:station2) {double(:station, zone: 2)}
  subject(:journey) { described_class.new }

  describe "#initialize" do
    it "updates entry_station with entry station" do
      expect{ journey.start(station) }.to change{ journey.entry_station }.to eq station
    end
  end

  describe "#end_journey" do
    it "updates exit_station with exit station" do
      expect{ journey.finish(station) }.to change{ journey.exit_station }.to(station)
    end
  end

  describe '#fare' do
    it "returns the minimum fare for a complete journey" do
      journey.start(station)
      journey.finish(station)
      expect(journey.fare).to eq min_fare
    end

    it "returns a penalty fare for an incomplete journey" do
      journey.finish(:penalty)
      expect(journey.fare).to eq penalty_fare
    end

    it "returns a fare of 1 when travelling within the same zone" do
      journey.start(station)
      journey.finish(station)
      expect(journey.fare).to eq Journey::MIN_FARE
    end

    it "returns a fare of 2 when travelling from zone 1 to zone 2" do
      journey.start(station)
      journey.finish(station2)
      expect(journey.fare).to eq 2
    end
  end

end
