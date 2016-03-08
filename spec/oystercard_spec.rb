require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:oystercard10) { allow(oystercard).to receive(:balance){ 10 } }
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
    it 'changes in_journey to true' do
      oystercard10
      expect{ oystercard.touch_in }.to change{ oystercard.in_journey? }.from(false).to(true)
    end

    it 'will raise error if balance is below min balance.' do
      expect{ oystercard.touch_in }.to raise_error("YOU TOO PO")
    end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out) }
    it 'changes in_journey to false' do
      oystercard10
      oystercard.touch_in
      expect{ oystercard.touch_out }.to change{ oystercard.in_journey? }.from(true).to(false)
    end
    
    it 'deducts the fare' do 
      expect {oystercard.touch_out }.to change { oystercard.balance }.by -(Oystercard::MIN_FARE)
    end
  
  end



end
