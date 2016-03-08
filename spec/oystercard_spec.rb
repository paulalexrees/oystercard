require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:oystercard10) { allow(oystercard).to receive(:balance){ 10 } }
  let(:Oystercard) { described_class }
  let(:station) { double :station }

  describe "#initialize" do
    it 'will begin with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end

    it 'will begin with a nil entry station' do
      expect(oystercard.entry_station).to eq nil
    end

    it 'will begin with an empty journey_history' do
      expect(oystercard.journeys).to eq []
    end
  end

  describe "#top_up" do
    it 'will increase the balance by the specified amount' do
      expect{ oystercard.top_up 20 }.to change{ oystercard.balance }.by(20)
    end

    it 'will raise error "TOO MUCH MONEY" if topping up exceeds card limit' do
      expect{ oystercard.top_up(Oystercard::CARD_LIMIT + 1)}.to raise_error("TOO MUCH MONEY - limit is £#{Oystercard::CARD_LIMIT}")
    end
  end

  describe "#touch_in" do
    it 'saves the entry station' do
      oystercard10
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq(station)
    end

    it 'changes in_journey to true' do
      oystercard10
      expect{ oystercard.touch_in(station) }.to change{ oystercard.in_journey? }.from(false).to(true)
    end

    it 'will raise error if balance is below min balance.' do
      expect{ oystercard.touch_in(station) }.to raise_error("YOU TOO PO")
    end
  end

  describe "#touch_out" do
    it 'changes in_journey to false' do
      oystercard10
      oystercard.touch_in(station)
      expect{ oystercard.touch_out }.to change{ oystercard.in_journey? }.from(true).to(false)
    end

    it 'deducts the fare' do
      expect{ oystercard.touch_out }.to change{ oystercard.balance }.by -(Oystercard::MIN_FARE)
    end

    it 'forgets entry station on touching out' do
      oystercard10
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end

 # describe '#journey_history'
 # end
  end
end
