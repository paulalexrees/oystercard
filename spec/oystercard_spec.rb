require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:Oystercard) { described_class }

  describe "#initialize" do
    it 'will begin with a balance of 0' do
      expect(oystercard.balance).to eq 0
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

  describe "#deduct" do
    it 'will decrease the balance by the specified amount' do
      expect{ oystercard.deduct(10) }.to change{ oystercard.balance }.by(-10)
    end

  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in) }

    it 'changes in_journey to true' do
      expect{ oystercard.touch_in }.to change{ oystercard.in_journey? }.from(false).to(true)
    end

  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out) }
  end
    
  describe "#in_journey?" do
    it { is_expected.to respond_to(:in_journey?) }
  end

  
end
