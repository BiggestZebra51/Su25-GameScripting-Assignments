# take a user string and print out capitalized version


#check if number
def CheckIfNum(userInput):
    if userInput.isdigit():
        print("Numbers can't be capitalized!")
    return userInput.isdigit()
#check if spaces
def CheckIfSpaces(userInput):
    if userInput.isspace():
        print("Spaces can't be capitalized!")
    return userInput.isspace()
#check if empty
def CheckIfEmpty(userInput):
    if not userInput:
        print("Input can't be empty")
        return True
    else:
        return False
#check if already capped
def CheckIfCapped(userInput):
    if userInput == str.upper(userInput):
        print("This is already capitalized!")
        return True
    else:
        return False
#check everything
def CheckAll(userInput):
    while CheckIfNum(userInput) or CheckIfSpaces(userInput) or CheckIfEmpty(userInput) or CheckIfCapped(userInput):
        userInput = input("Type something else: ")
    return userInput

strToUpper = input("Write something to capitalize: ")
print(str.upper(CheckAll(strToUpper)))

# Most simple way to do so
# print(str.upper(input("Write something to capitalize: ")))