require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }

  it {is_expected.to respond_to(:top_up).with(1).argument}

  it 'will begin with a balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'will increase the balance by the specified amount' do
    expect{ oystercard.top_up 20 }.to change{ subject.balance }.by 20
  end

  it 'will raise error "TOO MUCH MONEY" if topping up exceeds card limit' do
    expect{ oystercard.top_up(1000000)}.to raise_error("TOO MUCH MONEY")
  end

end
