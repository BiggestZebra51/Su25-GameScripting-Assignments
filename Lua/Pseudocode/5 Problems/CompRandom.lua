--get max number from user
--print out random number between 0 and userNum
--allow to play again

function printRandomNum()
    --variables
    local maxNum = nil
    local randomNumber = nil
    local playAgain = true

    --Setup random number generator
    math.randomseed(os.time()) -- seed the randomizer
    math.random() ; math.random() ; math.random() --get rid of any old values

    while (playAgain == true) do
        --reset variables
        maxNum = nil

        --Ask for number
        print("Give me a maximum whole number: ")
        while (maxNum == nil or maxNum < 1) do -- disallow numbers lower than 1
            maxNum = tonumber(io.read()) --Keep asking user until input is valid
        end

        --Print out random number between 1 and maxNum
        randomNumber = math.random(maxNum)
        print("The computer picked the random number: "..randomNumber)

        --Ask if user wants another random number
        print("Press Y for another number, any other key to exit: ")
        if (string.upper(io.read()) ~= "Y") then
            playAgain = false
        end
    end
    print("Thanks for playing! Goodbye.")
end