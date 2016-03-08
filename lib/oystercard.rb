class Oystercard

  attr_reader :balance

  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "TOO MUCH MONEY - limit is £#{CARD_LIMIT}" if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
  end

  def touch_out
  end

  def in_journey?
  end

end
