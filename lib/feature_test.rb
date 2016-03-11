require './lib/oystercard'
require './lib/station'
require './lib/journeylog'

station = Station.new(name:"Temple",zone: 1)
station2 = Station.new(name:"Monument",zone: 2)
station3 = Station.new(name:"Bank", zone: 3)

oyster = Oystercard.new

oyster.top_up(40)
oyster.touch_out(station)
p oyster.balance
p oyster.journeylog.journeys
oyster.touch_out(station2)
p oyster.balance
p oyster.journeylog.journeys
