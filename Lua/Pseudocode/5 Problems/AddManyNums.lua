--Take unknown number of numbers from user, add together, print result
function addManyNums()
    -- variables
    local sum = 0
    local getNextNumber = true
    -- Get the first number
    while getNextNumber == true do
        -- variables
        local inputNumber = nil

        -- Get number to add to sum
        while (inputNumber == nil) do --Keep asking user until input is valid
            -- Use tonumber to handle invalid input on store
            -- Invalid numbers return nil
            print("Number: ")
            inputNumber = tonumber(io.read())
        end
        -- Add number to sum
        sum = sum + inputNumber

        -- Ask to add another number
        print("Add another number? (y/n) ")
        if (string.upper(io.read()) ~= "Y") then
            getNextNumber = false
        end
    end
    -- Output sum
    print("Output: "..sum)
end