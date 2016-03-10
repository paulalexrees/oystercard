require 'journey'

describe Journey do

  let(:station){ double(:station) }
  subject(:journey) { described_class.new }

  describe "#start_journey" do
    it "updates entry_station with entry station" do
      expect{ journey.start(station) }.to change{ journey.entry_station }.to(station)
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
      expect(journey.fare).to eq Journey::MIN_FARE
      # GET RID OF MIN_FARE FROM OYSTERCARD
    end

    it "returns a penalty fare for an incomplete journey" do
      journey.finish(:penalty)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end

end
