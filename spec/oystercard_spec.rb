require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station){ double :station }
  let(:station2){ double :station }
  let(:topped){ allow(oystercard).to receive(:balance){20}}
  let(:topped_completed) { allow(oystercard).to receive_messages(balance:20, journey:{entry:station, exit:station2})}

  describe "#balance" do

    it 'will begin with a balance of 0' do
      expect(oystercard.balance).to eq 0
    end

    it 'will increase the balance by the specified amount' do
      balance1 = oystercard.balance
      oystercard.top_up(5)
      balance2 = oystercard.balance
      expect(balance2 > balance1).to be true
    end

  end

  describe "#top_up" do

    it 'should raise an error if the total balance added is above 90' do
      expect{oystercard.top_up(100)}.to raise_error(RuntimeError)
    end

    it 'should raise an error if the total balance after transaction is over 90' do
      oystercard.top_up(80)
      expect{oystercard.top_up(20)}.to raise_error(RuntimeError)
    end

  end

  describe "#journey" do

    it 'should verify in journey' do
       expect(oystercard).not_to be_in_journey
     end

  end

  describe "#touch in" do

    it 'should start a new journey when not in a journey' do
      topped
      oystercard.touch_in(station)
      expect(oystercard.in_journey?).to be true
    end

    it 'should prevent journey if balance is under 1 pound' do
      expect{oystercard.touch_in(station) while true}.to raise_error(RuntimeError)
    end

 end

  describe "#touch out" do

    it 'should confirm touch out' do
      topped_completed
      expect(oystercard.in_journey).to be false
    end

    it 'should deduct the correct amount for journey' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect { oystercard.touch_out(station2) }.to change{ oystercard.balance }.by (-1)
    end

    xit 'should complete journey history' do
      topped_completed
      expect(oystercard.journey_history[0]).to eq({entry:station, exit:station2})
    end
    it 'should charge penalty fare if touch_in has not been called' do
      oystercard.top_up(5)
      expect{ oystercard.touch_out(station) }.to change{oystercard.balance}.by -6
    end

end

end
