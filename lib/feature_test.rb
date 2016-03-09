require './lib/oystercard'
require './lib/station'

p station = Station.new("Temple", 1)
p station2 = Station.new("Monument", 2)

p oyster = Oystercard.new

#p oyster.balance

p oyster.top_up (8)

#p oyster.top_up(2)

#p oyster.in_journey?
p "Touching in"
p oyster.touch_in(station)
p oyster.journey_history
p "touching out"
p oyster.touch_out(station2)
#
#
p oyster.journey_history
# p oyster.current_journey
p
p oyster.journey_history[0]
