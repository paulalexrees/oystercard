require_relative 'station'
require_relative 'journey'

class Oystercard
attr_reader :balance, :journey_history

MAX_BALANCE = 90
DEFAULT_BALANCE = 0

  def initialize balance=DEFAULT_BALANCE
    @balance = balance
    @journey_history = []
  end

  def top_up amount
    raise "exceeded max top up" if @balance + amount > MAX_BALANCE
      @balance += amount
  end

  def touch_in(station, journey_class=Journey.new)
    raise "not enough funds" if balance < Journey::MIN_FARE
    # touch_out(:penalty) if !!journey
    # @journey = journey_class
    journey.start
  end

  def touch_out station
    journey.finish station
    deduct journey.fare # => HANDLED BY JOURNEY LOG
    # log journey
  end

  private
  attr_reader :journey

  def deduct amount
    @balance -= amount
  end

  def log journey
    @journey_history << journey
  end
end
