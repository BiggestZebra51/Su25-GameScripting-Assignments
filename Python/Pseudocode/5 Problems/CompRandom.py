import random

# Have the user define a maximum whole number, print out a random number between 0 and their number. Allow the user to play again or quit.


# Is the input an integer
def IsInt(userInput):
    # We only want whole numbers above 1 so we don't need to check for floats nor negatives
    # isdecimal() is purely 0-9 characters
    return userInput.isdecimal()

# While not a whole number or less than 1, keep promting
def TryAgain(userInput):
    while not IsInt(userInput) or int(userInput) < 1:
        userInput = input("That is not a whole number, please try again: ")
    return userInput

# Get user input and return sum with user input
def GetMaximumNumber():
    # Get Number
    userInput = input("Give a maximum whole number: ")
    userInput = TryAgain(userInput)
    return int(userInput)

# Ask user if they want to go again
def CheckContinue():
    userInput = ""
    # Ask to add another number
    while userInput != "Y" and userInput != "N":
        # Store uppercase for all checks
        userInput = str.upper(input("Generate another number? (y/n): "))
    # Ouput true if Y was entered
    return userInput == "Y"

# Ask user for maximum number and generate a random number
def GuessNumber():
    # Get the user defined maximum number
    maxNum = GetMaximumNumber()
    randomNumber = random.randint(1, maxNum)
    print("The computer picked the random number: " + str(randomNumber))


# Do the first loop
GuessNumber()
# Generate random number to user input
while CheckContinue():
    GuessNumber()

print("Thanks for playing! Goodbye.")