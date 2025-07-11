# Have user input two numbers, add them together and print the result.

# Is the input a number
def IsNum(userInput):
    isFloat = False
    try:
        float(userInput)
        isFloat = True
    except:
        isFloat = False

    return isFloat
# def IsNum(userInput):
#    return bool(userInput.isdigit() or isinstance(userInput, float))

# While not a number, keep promting
def TryAgain(userInput):
    while not IsNum(userInput):
        userInput = input("That is not a number, please try again: ")
    return userInput

num1 = input("Enter a number: ")
num1 = TryAgain(num1)
num2 = input("Enter another number: ")
num2 = TryAgain(num2)

print(num1+" + "+num2+" = "+str(float(num1) + float(num2)))