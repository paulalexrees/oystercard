require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard
attr_reader :balance, :journey_history, :journeylog

MAX_BALANCE = 90
DEFAULT_BALANCE = 0

  def initialize(balance=DEFAULT_BALANCE, journeylog = Journeylog)
    @balance = balance
    @journey_history = []
    @journeylog = journeylog
  end

  def top_up amount
    raise "exceeded max top up" if @balance + amount > MAX_BALANCE
      @balance += amount
  end

  def touch_in(station)
    raise "not enough funds" if balance < Journey::MIN_FARE
    journeylog.start(station)
  end

  def touch_out(station)
    journeylog.finish(station)
    deduct(journeylog.journey.fare)
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
