extends Node

# Random float number
func randfl(minimum, maximum):
	randomize()
	return randf() * (maximum - minimum) + minimum

# Random number, floored
func rand(minimum, maximum = null):
	randomize()
	if maximum == null:
		maximum = minimum
		minimum = 0
	return floor(randf() * (maximum - minimum + 1)) + minimum

func randOneIn(maximum = 2):
	return rand(0, maximum) == 0

func randOneFrom(items):
	return items[rand(items.size() - 1)]