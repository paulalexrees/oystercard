require_relative 'station'
require_relative 'journey'

class Oystercard

attr_reader :balance, :in_journey, :entry_station, :exit_station, :current_journey, :journey_history

MIN_BALANCE = 1
MAX_BALANCE = 90
DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @journey_history = []
  end

  def top_up(amount)
    if amount > MAX_BALANCE || @balance + amount > MAX_BALANCE
      raise "exceeded max top up"
    else
      @balance += amount
    end
  end


  def in_journey?
    @in_journey
  end

  def touch_in(station)
    raise "not enough funds" if @balance < MIN_BALANCE
    @in_journey = true
    @journey = Journey.new
    @journey.start_journey(station)
    @journey_history << @journey
  end

  def touch_out(station)
    @in_journey = false
    @journey.end_journey(station)
    deduct(@journey.fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end





end
