class Journey

  attr_reader :current_journey

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

end
