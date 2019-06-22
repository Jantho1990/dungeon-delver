extends Node

# Random float number
func randfl(minimum, maximum = null):
	randomize()
	if maximum == null:
		maximum = minimum
		minimum = 0.0
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

# Return a random integer stepped
func rand_step(step, minimum, maximum = null):
	return stepify(float(rand(minimum, maximum)), step)

# Round to the nearest integer. Place is for tens, hundreds, etc.
func round_int_places(value, place = 1):
	var zeroes = pow(10, place)
	var rounded_value = round(value / zeroes)
	return rounded_value * zeroes