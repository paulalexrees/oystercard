require 'journey'

describe Journey do

  let(:station){double(:station)}
  subject {described_class.new}

  describe "#initialize" do
    it "initializes with a current journey hash" do
      expect(subject.current_journey).to eq({entry: nil, exit: nil})
    end
  end

  describe "#start_journey" do
    it "updates current_journey with entry station" do
      subject.start_journey(station)
      expect(subject.current_journey[:entry]).not_to be nil
    end
  end

  describe "#end_journey" do
    it "updates current_journey with exit station" do
      subject.end_journey(station)
      expect(subject.current_journey[:exit]).not_to be nil
    end
  end

  describe '#fare' do
    it "by default it returns the minimum fare for a journey" do
      subject.start_journey(station)
      subject.end_journey(station)
      expect(subject.fare).to eq 1
    end

    it "applies the penalty fare if entry or exit was not respected" do
      expect(subject.fare).to eq 6
    end
  end

  describe '#complete?' do

    it "returns true if journey has a start and end station" do
      subject.start_journey(station)
      subject.end_journey(station)
      expect(subject.complete?).to eq true
    end

    it "returns false if journey is missing a start or end station" do
      subject.start_journey(station)
      expect(subject.complete?).to eq false
    end
  end
end
