--Take a user string and return it as capitalized
function changeToUppercase()
    --variables
    local lowercaseInput = nil
    local uppercaseOutput = nil

    -- while user input is invalid or not able to be capitalized, ask user for input
    while lowercaseInput == nil or lowercaseInput == ""
                                or lowercaseInput == string.upper(lowercaseInput)
                                or tonumber(lowercaseInput) do
        print("Enter text to capitalize")
        lowercaseInput = io.read()
    end
    -- Once valid user input, convert to uppercase
    uppercaseOutput = string.upper(lowercaseInput)

    --return capitalized string
    return uppercaseOutput
end

--Take a user string and print it as capitalized
function printUppercase()
    --print capitalized string
    print(changeToUppercase())
end