--Take two numbers from user, add together, return result
function twoNumberSum()
    -- variables
    local num1 = nil
    local num2 = nil
    local sum = 0
    -- Get the first number
    while num1 == nil or num1 == "" or not tonumber(num1) do
        print("What is your first number: ")
        num1 = io.read()
    end
    -- Get the second number
    while num2 == nil or num2 == "" or not tonumber(num2) do
        print("What is your second number: ")
        num2 = io.read()
    end

    --Add the two numbers and store them in sum
    sum = num1 + num2
    -- Return the sum of the two numbers
    return sum
end

--Take two numbers from user, add together, print result
function printTwoNumberSum()
    -- Print the sum of two numbers
    print(twoNumberSum())
end