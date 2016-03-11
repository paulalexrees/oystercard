class Oystercard

attr_reader :balance, :journeylog

MAX_BALANCE = 90
DEFAULT_BALANCE = 0

  def initialize(journeylog = Journeylog)
    @balance = DEFAULT_BALANCE
    @journeylog = journeylog.new(journey_class: Journey)
  end

  def top_up(amount)
    raise "exceeded max top up" if card_total(amount) > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "not enough funds" if balance < Journey::MIN_FARE
    deduct(journeylog.journey.fare) if journeylog.journey
    journeylog.start(station)
  end

  def touch_out(station)
    journeylog.finish(station)
    deduct(journeylog.journeys.last.fare)
  end

  private

  def deduct amount
    @balance -= amount
  end

  def card_total(amount)
    @balance + (amount)
  end

end
