require_relative 'journey'

class Journeylog

  attr_reader :journey

  def initialize(journey_class:)
    @journey_class = journey_class
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
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey
    @journey = journey || @journey = @journey_class.new
  end

  def log journey
    @journeys << journey
    @journey = nil
  end

end
