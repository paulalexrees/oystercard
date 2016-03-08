require './lib/oystercard'

p oyster = Oystercard.new
p "balance"
p oyster.balance
p "topup90"
p oyster.top_up(90)
p "injourney"
p oyster.in_journey?
p "touchin"
p oyster.touch_in("station")
p "entry_station"
p oyster.entry_station
p "touch_out"
p oyster.touch_out
p "station"
p oyster.entry_station
p "injourney"
p oyster.in_journey?
p "history"
p oyster.journey_history

