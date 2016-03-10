require_relative 'journey'

class Journeylog

  attr_reader :journeys

  def initialize(journey_klass: )
    @journey_class = journey_klass
    @journeys = []
  end

  def start station
    finish(:penalty) if !!@journey
    @journey = current_journey
    @journey.start station
  end

  def finish station

  end


  private
  attr_reader :journey_class, :current_journey, :journey

  def current_journey
    if journey.nil?
      journey_class.new
    else
      journey
    end
  end
end
