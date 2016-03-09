require 'station'


describe Station do
subject(:station) { described_class.new("bond", 1) }

  describe '#initialize' do
    it 'initializes a station with name' do
      expect(station.name).to be_a String
    end
    it 'initializes a station with a zone' do
      expect(station.zone).to be_a Integer
    end
  end
end
