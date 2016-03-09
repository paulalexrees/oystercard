require 'journey'

describe Journey do
  subject {described_class.new}
  let(:station){double(:station)}

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

end
