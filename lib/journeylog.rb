require_relative 'journey'

class Journeylog

  attr_reader :journeys, :journey

  def initialize(journey_klass: )
    @journey_class = journey_klass
    @journeys = []
  end

  def start station
    finish(:penalty) if !!@journey
    current_journey
    @journey.start station
  end

  def finish station
    current_journey
    @journey.finish station
    log @journey
    @journey = nil
  end

  private
  attr_reader :journey_class, :current_journey

  def current_journey
    @journey = journey || journey_class.new
  end

  def log journey1
    @journeys << journey1
  end

end
