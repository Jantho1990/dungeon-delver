extends "Score.gd"

# List of possible score values.


# Create a valid score value.
func createScoreValue(lower = 1, upper = 1000, step = 10):
	return math.rand_step(step, lower, upper)

func createScoreValueTens(lower = 10, upper = 90):
	return createScoreValue(lower, upper, 10)

func createScoreValueHundreds(lower = 100, upper = 900):
	return createScoreValue(lower, upper, 100)

func createScoreValueThousands(lower = 1000, upper = 9000):
	return createScoreValue(lower, upper, 1000)

func createScoreValueTenThousands(lower = 10000, upper = 90000):
	return createScoreValue(lower, upper, 10000)
