class Oystercard

  attr_reader :balance, :entry_station, :journeys
  MIN_FARE = 1
  CARD_LIMIT = 90

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "TOO MUCH MONEY - limit is £#{CARD_LIMIT}" if balance + amount > CARD_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "YOU TOO PO" if balance < MIN_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end


private

  def deduct(amount)
    @balance -= amount
  end

end
