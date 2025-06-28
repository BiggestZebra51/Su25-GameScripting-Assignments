--random number 10 times, see how many are even and how many are odd
function printEvenOdds()
    --variables
    local zeroCount = 0
    local evenCount = 0
    local oddCount = 0
    local checkNum = nil

    --Setup random number generator
    math.randomseed(os.time()) -- seed the randomizer
    math.random() ; math.random() ; math.random() -- get rid of any old values

    for i = 1, 10, 1 do
        checkNum = math.random(0, 100)

        if (checkNum == 0) then
            zeroCount = zeroCount + 1
            print(checkNum.." is zero")
        elseif (checkNum%2 == 0) then -- 1 means odd, 0 means even
            evenCount = evenCount + 1
            print(checkNum.." is even")
        else
            oddCount = oddCount + 1
            print(checkNum.." is odd")
        end
    end

    print("Zeroes: "..zeroCount)
    print("Left: "..oddCount)
    print("Right: "..evenCount)
end