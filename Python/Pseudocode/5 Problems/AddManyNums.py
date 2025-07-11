# Get an unknown amount of numbers from the user and add them together, print out the result.

# Is the input a number
def IsNum(userInput):
    try:
        float(userInput)
        isFloat = True
    except:
        isFloat = False

    return isFloat

# While not a number, keep promting
def TryAgain(userInput):
    while not IsNum(userInput):
        userInput = input("That is not a number, please try again: ")
    return userInput

# Ask user if they want to go again
def CheckContinue():
    userInput = ""
    # Ask to add another number
    while userInput != "Y" and userInput != "N":
        # Store uppercase for all checks
        userInput = str.upper(input("Add another number? (y/n): "))
    # Ouput true if Y was entered
    return userInput == "Y"
        
# Get user input and return sum with user input
def AddNumber(sum):
    # Get Number
    userInput = input("Enter a number to add: ")
    userInput = TryAgain(userInput)
    # Add to sum
    sum += float(userInput)
    return sum


# Initialize variables
totalSum = AddNumber(0)
# Get and add numbers
while CheckContinue():
    totalSum = AddNumber(totalSum)

print("Output: " + str(totalSum))
