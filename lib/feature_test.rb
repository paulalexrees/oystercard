require './lib/oystercard'
require './lib/station'
require './lib/journeylog'

station = Station.new(name:"Temple",zone: 1)
station2 = Station.new(name:"Monument",zone: 2)
station3 = Station.new(name:"Bank", zone: 3)

oyster = Oystercard.new

oyster.top_up(40)
#oyster.touch_in(station)

log = Journeylog.new(journey_klass: Journey)

 p log.finish(station)
 #p log.start(station2)
 #p log.finish(station3)
p log.journeys
#p log.journeys[1]
