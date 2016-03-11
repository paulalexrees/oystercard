class Journey

  attr_reader :entry_station, :exit_station
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = :nil
    @exit_station = :nil
  end

  def start station
    @entry_station = station
  end

  def finish station
    @exit_station = station
  end

  def fare
    penalty_due? ? PENALTY_FARE : zone_change
  end

  def zone_change
    (entry_station.zone - exit_station.zone).abs + MIN_FARE
  end

  private

  def penalty_due?
    entry_station == :nil || exit_station == :nil
  end


end
