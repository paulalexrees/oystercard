require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:journey){ double :journey }
  let(:station){ double :station }
  let(:station2){ double :station }
  let(:topped){ allow(oystercard).to receive(:balance){20}}
  let(:topped_completed) { allow(oystercard).to receive_messages(balance:20, journey:{entry:station, exit:station2})}
  let(:journey_start) { allow(journey).to receive_messages(start_journey: nil) }

  describe "#balance" do

    it 'begins with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end

    it 'increases the balance by the specified amount' do
      balance1 = oystercard.balance
      oystercard.top_up(5)
      balance2 = oystercard.balance
      expect(balance2 > balance1).to be true
    end

  end

  describe "#top_up" do

    it 'raises an error if the total balance added is above 90' do
      expect{oystercard.top_up(100)}.to raise_error(RuntimeError)
    end

    it 'raises an error if the total balance after transaction is over 90' do
      oystercard.top_up(80)
      expect{oystercard.top_up(20)}.to raise_error(RuntimeError)
    end

  end

  describe "#touch in" do

    it 'creates a new journey on touching in' do
      topped
      expect{ oystercard.touch_in(station) }.to change{ oystercard.journey }.to be_a(Journey)
    end

    it 'gives journey an entry station' do
      topped
      expect(journey).to receive(:start_journey).with(station)
      oystercard.touch_in(station, journey)
    end

    it 'ends previous journey if already in one' do
      topped
      journey_start
      oystercard.touch_in(station, journey)
      expect(oystercard).to receive(:touch_out).with("Penalty")
      oystercard.touch_in(station, journey)
    end

    it 'prevents journey if balance is under 1 pound' do
      expect{oystercard.touch_in(station) while true}.to raise_error(RuntimeError)
    end

 end

  describe "#touch out" do

    it 'resets journey on touch out' do
      topped
      expect(oystercard.journey).to receive(:clear_journey)
      oystercard.touch_out(station)
    end

    it 'deducts the correct amount for journey' do
      #needs to go to Journey class
      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect { oystercard.touch_out(station2) }.to change{ oystercard.balance }.by -(Oystercard::MIN_FARE)
    end

    it 'tells journey to end the journey' do
      topped
      oystercard.touch_out(station)
      expect(oystercard.journey).to receive(:clear_journey)
      oystercard.touch_out(station2)
    end

    it 'charges penalty fare if touch_in has not been called' do
      #needs to go into Journey class
      oystercard.top_up(5)
      expect{ oystercard.touch_out(station) }.to change{oystercard.balance}.by -6
    end

end

end
