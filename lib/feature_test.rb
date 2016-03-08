require './lib/oystercard'

p oyster = Oystercard.new

p oyster.balance

p oyster.top_up(90)
p oyster.in_journey?
p oyster.touch_in(station)
p oyster.entry_station

p oyster.touch_out
p oyster.in_journey?
