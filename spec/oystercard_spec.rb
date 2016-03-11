require 'oystercard'

describe Oystercard do
  min_fare = Journey::MIN_FARE
  subject(:oystercard) { described_class.new(20)}
  let(:journey){ double(:journey, start: nil, finish: nil, fare: min_fare) }
  let(:station){ double :station }
  let(:station2){ double :station }
  let(:zero_balance){ allow(oystercard).to receive(:balance){0}}
  let(:journeylog) { double :journeylog }

  describe "#balance" do
    it 'begins with a balance of 0' do
      expect(described_class.new.balance).to eq 0
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
      oystercard.top_up(60)
      expect{oystercard.top_up(20)}.to raise_error(RuntimeError)
    end
  end

    it 'prevents journey if balance is under 1 pound' do
      zero_balance
      expect{oystercard.touch_in(station) while true}.to raise_error(RuntimeError)
    end

  describe "#touch in" do
    it 'tells journeylog to start a journey' do
      allow(oystercard).to receive(:journeylog).and_return(journeylog)
      expect(oystercard.journeylog).to receive(:start).with(station)
      oystercard.touch_in(station)
    end
  end

  describe "#touch out" do
    it 'tells journeylog to finish a journey' do
      allow(oystercard).to receive(:journeylog).and_return(journeylog)
      expect(oystercard.journeylog).to receive(:finish).with(station)
      oystercard.touch_out(station)
    end
  end
end
