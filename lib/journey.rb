class Journey

  attr_reader :current_journey
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @current_journey = {entry: nil, exit: nil}
  end

  def start_journey(station)
    @current_journey[:entry] = station
    @current_journey
  end

  def end_journey(station)
    @current_journey[:exit] = station
  end

  def fare
    if @current_journey[:entry] == nil || @current_journey[:exit] == nil
      PENALTY_FARE
    else
      MIN_FARE
    end
  end
end
