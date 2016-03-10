class Journey

  attr_reader :entry_station, :exit_station
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    # todo: init with entry_station - change in oystercard class
  end

  def start station
    @entry_station = station
  end

  def finish station
    @exit_station = station
  end

  def fare
    (entry_station == :penalty || exit_station == :penalty) ? PENALTY_FARE : MIN_FARE
  end

end
