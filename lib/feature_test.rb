require './lib/oystercard'
require './lib/station'

station = Station.new("Temple", 1)
station2 = Station.new("Monument", 2)

oyster = Oystercard.new

#p oyster.balance

oyster.top_up (20)
p oyster.journey.complete?
#p oyster.in_journey?
p "Touching in"
 oyster.touch_in(station)
p "Complete?"
p oyster.journey.complete?
p "Touching out"
oyster.touch_out(station2)
p "Complete?"
p oyster.journey.complete?
p oyster.balance
p oyster.journey
p "Touching out, forgot to touch in"
 oyster.touch_out(station2)
p oyster.journey.complete?
p oyster.balance
p "Touching in"
oyster.touch_in(station)
p oyster.balance
p oyster.journey.complete?
p "Forgot to touch out, touching in again"
oyster.touch_in(station)
p oyster.journey.complete?
p "Touch out properly this time"
oyster.touch_out(station2)
p oyster.balance

#-----------------------

# oyster = Oystercard.new
# temple = Station.new("Temple",1)
# bond = Station.new("Bond",1)
# oyster.top_up(20)
# "Oyster ready for use"
#
#
# oyster.touch_in(temple)
# JourneyLog - start at temple
#             sets Journey.in = temple
# JourneyLog @journeys still empty
# oyster is now in_journey
#
#
# oyster.touch_out(bond)
# JourneyLog - end at bond
#             sets Journey.out = bond
#             wraps up and saves into @journeys
#
#     oyster.deduct(Journey.fare)
#         Journey.fare will look at
#         @in and @out and return 1
