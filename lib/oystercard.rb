require_relative 'station'
require_relative 'journey'

class Oystercard

attr_reader :balance, :journey, :in_journey, :current_journey, :journey_history

MIN_BALANCE = 1
MAX_BALANCE = 90
DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @journey = Journey.new
    @journey_history = []
  end

  def top_up(amount)
    raise "exceeded max top up" if @balance + amount > MAX_BALANCE
      @balance += amount
  end

  def touch_in(station)
    raise "not enough funds" if balance < MIN_BALANCE
    if journey.complete?
      @in_journey = true
      journey.start_journey(station)
    else
      deduct(journey.fare)
      journey.clear_journey
      touch_in(station)
    end
  end

  def touch_out(station)
    if journey.current_journey[:entry] != nil
      journey.end_journey(station)
      @in_journey = false
      deduct(journey.fare)
      @journey_history << journey.dup
      journey.clear_journey
    else
      journey.end_journey(station)
      deduct(journey.fare)
      @journey_history << journey.dup
      journey.clear_journey
    end
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end





end
