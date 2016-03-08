require './lib/oystercard'

p oyster = Oystercard.new

p oyster.balance

p oyster.top_up(90)
p oyster.deduct(5)
