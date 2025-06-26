--Jacob Crawford
--A game to guess a number between 1 and 100 chosen by the computer

function guessingGame()
    --variables
    local playGame = "Y"

    --Setup random number generator
    math.randomseed(os.time()) -- seed the randomizer
    math.random() ; math.random() ; math.random() --get rid of any old values

    --Game loop
    while playGame == "Y" do
        --variables
        local randomNumber
        local guessCount = 0
        local userGuess = nil

        --Pick random number
        randomNumber = math.random(1, 5)

        --Get user guesses
        print("Try to guess the hidden number in 7 tries!")
        while (randomNumber ~= userGuess and guessCount < 7) do
            print("Enter your guess: ")
            userGuess = tonumber(io.read())
            -- ensure input is a number between 1 and 100
            if(userGuess and userGuess >= 1 and userGuess <= 100) then
                guessCount = guessCount + 1
            else
                print("Please enter a number between 1 and 100")
            end
        end

        -- Print if the user won or not
        if (randomNumber == userGuess) then
            print("You won in "..guessCount.." guesses! The number was "..randomNumber)
        else
            print("You lose! The number was "..randomNumber)
        end

        --Ask if user wants to play again
        print("Press Y to play again, any other key to exit: ")
        playGame = io.read()
        if string.upper(playGame) ~= "Y" then
            break
        else
            playGame = "Y" -- ensure capital y
        end
    end
end
