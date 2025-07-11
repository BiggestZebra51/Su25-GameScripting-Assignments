# Get a random number. If the number is even print “RIGHT”, if it’s odd, print “LEFT”. Do this ten times. Print out how many times it was “LEFT” and how many times it was “RIGHT”.
import random

# Initialize variables
zeroCount = 0
evenCount = 0
oddCount = 0

# Run 10 times
for i in range(0, 10):
  # Random number 0 to 100
  checkNum = random.randint(0, 100)
  if checkNum == 0: # Zero
    zeroCount += 1
    print(str(checkNum) + " is zero")
  elif checkNum % 2 == 0: # Even
    evenCount += 1
    print(str(checkNum) + " is even")
  else: # Odd
    oddCount += 1
    print(str(checkNum) + " is odd")

# Print results
print("Zeros: " + str(zeroCount))
print("Left: " + str(evenCount))
print("Right: " + str(oddCount))



