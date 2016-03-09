require './lib/oystercard'
require './lib/station'

station = Station.new("Temple", 1)
station2 = Station.new("Monument", 2)

oyster = Oystercard.new

#p oyster.balance

oyster.top_up (8)

#p oyster.top_up(2)

#p oyster.in_journey?
p "Touching in"
p oyster.touch_in(station)
#p oyster.journey_history
p "Touching out"
p oyster.touch_out(station2)
p oyster.balance
p "Forget to touch in"
p oyster.touch_out(station2)
p oyster.balance
p oyster.journey_history
# p oyster.current_journey
