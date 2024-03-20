-- myremoveduplicates 
myremoveduplicates :: Eq a => [a] -> [a]
myremoveduplicates list
  | null list                    = []
  | elem (head list) (tail list) =               myremoveduplicates (tail list)
  | otherwise                    = (head list) : myremoveduplicates (tail list)

-- myremoveduplicates_pm
myremoveduplicates_pm :: Eq a => [a] -> [a]
myremoveduplicates_pm [] = []
myremoveduplicates_pm (x:xs)
  | elem x xs =     myremoveduplicates_pm xs
  | otherwise = x : myremoveduplicates_pm xs

-- myintersection
myintersection :: Eq a => [a] -> [a] -> [a]
myintersection list1 list2
  | null list1 || null list2 = []
  | elem (head list1) list2  = (head list1) : myintersection (tail list1) list2
  | otherwise                =                myintersection (tail list1) list2

-- myintersection_pm
myintersection_pm :: Eq a => [a] -> [a] -> [a]
myintersection_pm [] _ = []
myintersection_pm (x:xs) list2
  | elem x list2 = x : myintersection_pm xs list2
  | otherwise    =     myintersection_pm xs list2

-- mynthtail 
mynthtail :: Int -> [a] -> [a]
mynthtail n list 
  | null list = []
  | n <= 0    = list
  | otherwise = mynthtail (n - 1) (tail list)

-- mynthtail_pm
mynthtail_pm :: Int -> [a] -> [a]
mynthtail_pm n []     = []
mynthtail_pm 0 list   = list
mynthtail_pm n (x:xs) = mynthtail_pm (n - 1) xs

-- mylast
mylast :: Eq a => [a] -> [a]
mylast list
  | null list        = []
  | null (tail list) = list
  | otherwise        = mylast (tail list)

-- mylast_pm
mylast_pm :: Eq a => [a] -> [a]
mylast_pm []     = []
mylast_pm [x]    = [x]
mylast_pm (_:xs) = mylast_pm xs

-- myreverse
myreverse :: [a] -> [a]
myreverse list = reversehelper list []
-- helper function with accumlator
reversehelper :: [a] -> [a] -> [a]
reversehelper list acc
  | null list = acc
  | otherwise = reversehelper (tail list) (head list : acc)

-- myreverse_pm
myreverse_pm :: [a] -> [a]
myreverse_pm list = myreversehelper_pm list []
-- helper function with accumlator 
myreversehelper_pm :: [a] -> [a] -> [a]
myreversehelper_pm [] acc     = acc
myreversehelper_pm (x:xs) acc = myreversehelper_pm xs (x:acc)

-- myreplaceall
myreplaceall :: Eq a => a -> a -> [a] -> [a]
myreplaceall new old list = replacehelper new old list
replacehelper :: Eq a => a -> a -> [a] -> [a]
replacehelper new old list
  | null list         = []
  | head list == old  = new         : replacehelper new old (tail list)
  | otherwise         = (head list) : replacehelper new old (tail list)

-- myreplaceall_pm
myreplaceall_pm :: Eq a => a -> a -> [a] -> [a]
myreplaceall_pm new old []     = []
myreplaceall_pm new old (x:xs) 
  |  x == old = new : myreplaceall_pm new old xs 
  | otherwise =   x : myreplaceall_pm new old xs

-- myordered
myordered :: Ord a => [a] -> Bool
myordered list = orderedhelper list
orderedhelper :: Ord a => [a] -> Bool
orderedhelper list = null list || null (tail list) || (head list) <= head (tail list) && orderedhelper (tail list)

-- myordered_pm
myordered_pm :: Ord a => [a] -> Bool
myordered_pm []       = True
myordered_pm [_]      = True
myordered_pm (x:y:xs) = x <= y && myordered_pm (y:xs)

-- computeFees
computeFees :: String -> Int
computeFees input = calculateFees (splitBySemicolon input)
-- id, fname, lname, age, credits, degree seeking, major, academic standing, fin aid, fin aid amount
-- id, fname, lname, age, credits, degree seeking, cert/senior, major
calculateFees :: [String] -> Int
calculateFees [] = 0
calculateFees (_:_:_:_:credits:"N":"S":xs) = seniorStudentFee (read credits) 
calculateFees (_:_:_:_:credits:"N":"C":xs) = certStudentFee (read credits)
calculateFees (_:_:_:_:credits:"Y":_:_:xs) 
  | elem "N" xs = degreeSeekingFee (read credits) 0
  | otherwise   =  degreeSeekingFee (read credits) (read (last xs))

certStudentFee :: Int -> Int
certStudentFee creditHours = 700 + 300 * creditHours

degreeSeekingFee :: Int -> Int -> Int
degreeSeekingFee creditHours famt 
  | creditHours <= 12 = 150 + 275 * creditHours - famt
  | otherwise         = 150 + 275 * 12 - famt

seniorStudentFee :: Int -> Int
seniorStudentFee creditHours
    | creditHours <= 6 = 100 
    | otherwise        = 100 + 50 * (creditHours - 6)

splitBySemicolon :: String -> [String]
splitBySemicolon str = splitHelper str []

splitHelper :: String -> String -> [String]
splitHelper [] acc = [acc]
splitHelper (x:xs) acc
    | x == ';'  = acc : splitHelper xs []
    | otherwise = splitHelper xs (acc ++ [x])

{-
main :: IO ()
main = do
    -- Test cases
    print $ "Test cases:"
    
    print $ "myremoveduplicates"
    print $ myremoveduplicates "abacad"                 -- Output: "bcad"
    print $ myremoveduplicates [3,2,1,3,2,2,1,1]        -- Output: [3,2,1]
    print $ "myremoveduplicates_pm"
    print $ myremoveduplicates_pm "abacad"              -- Output: "bcad"
    print $ myremoveduplicates_pm [3,2,1,3,2,2,1,1]     -- Output: [3,2,1]

    print $ "myintersection"
    print $ myintersection "abc" "bcd"                  -- Output: "bc"
    print $ myintersection [3,4,2,1] [5,4,1,6,2]        -- Output: [4,2,1]
    print $ myintersection [] [1,2,3]                   -- Output: []
    print $ myintersection "abc" ""                     -- Output: ""
    print $ "myintersection_pm"
    print $ myintersection_pm "abc" "bcd"               -- Output: "bc"
    print $ myintersection_pm [3,4,2,1] [5,4,1,6,2]     -- Output: [4,2,1]
    print $ myintersection_pm [] [1,2,3]                -- Output: []
    print $ myintersection_pm "abc" ""                  -- Output: ""
    
    print $ "mynthtail"
    print $ mynthtail 0 "abcd"                          -- Output: "abcd"
    print $ mynthtail 1 "abcd"                          -- Output: "bcd"
    print $ mynthtail 2 "abcd"                          -- Output: "cd"
    print $ mynthtail 3 "abcd"                          -- Output: "d"
    print $ mynthtail 4 "abcd"                          -- Output: ""
    print $ mynthtail 2 [1, 2, 3, 4]                    -- Output: [3,4]
    print $ mynthtail 4 [1, 2, 3, 4]                    -- Output: []
    print $ "mynthtail_pm"
    print $ mynthtail_pm 0 "abcd"                       -- Output: "abcd"
    print $ mynthtail_pm 1 "abcd"                       -- Output: "bcd"
    print $ mynthtail_pm 2 "abcd"                       -- Output: "cd"
    print $ mynthtail_pm 3 "abcd"                       -- Output: "d"
    print $ mynthtail_pm 4 "abcd"                       -- Output: ""
    print $ mynthtail_pm 2 [1, 2, 3, 4]                 -- Output: [3,4]
    print $ mynthtail_pm 4 [1, 2, 3, 4]                 -- Output: []

    print $ "mylast"
    print $ mylast ""                                   -- Output: ""
    print $ mylast "b"                                  -- Output: "b"
    print $ mylast "abcd"                               -- Output: "d"
    print $ mylast [1, 2, 3, 4]                         -- Output: [4]
    print $ mylast ([] :: [Int])                        -- Output: []
    print $ "mylast_pm"
    print $ mylast_pm ""                                -- Output: ""
    print $ mylast_pm "b"                               -- Output: "b"
    print $ mylast_pm "abcd"                            -- Output: "d"
    print $ mylast_pm [1, 2, 3, 4]                      -- Output: [4]
    print $ mylast_pm ([] :: [Int])                     -- Output: []

    print $ "myreverse"
    print $ myreverse ""                                -- Output: ""
    print $ myreverse "abc"                             -- Output: "cba"
    print $ myreverse [1, 2, 3]                         -- Output: [3, 2, 1]
    print $ myreverse ([] :: [Int])                     -- Output: []
    print $ "myreverse_pm"
    print $ myreverse_pm ""                             -- Output: ""
    print $ myreverse_pm "abc"                          -- Output: "cba"
    print $ myreverse_pm [1, 2, 3]                      -- Output: [3, 2, 1]
    print $ myreverse_pm ([] :: [Int])                  -- Output: []

    print $ "myreplaceall"
    print $ myreplaceall 3 7 [7, 0, 7, 1, 7, 2, 7]      -- Output: [3,0,3,1,3,2,3]
    print $ myreplaceall 'x' 'a' ""                     -- Output: ""
    print $ myreplaceall 'x' 'a' "abacad"               -- Output: "xbxcxd"
    print $ "myreplaceall_pm"
    print $ myreplaceall_pm 3 7 [7, 0, 7, 1, 7, 2, 7]   -- Output: [3,0,3,1,3,2,3]
    print $ myreplaceall_pm 'x' 'a' ""                  -- Output: ""
    print $ myreplaceall_pm 'x' 'a' "abacad"            -- Output: "xbxcxd"

    print $ "myordered"
    print $ myordered ([] :: [Int])                     -- Output: True
    print $ myordered [1]                               -- Output: True
    print $ myordered [1,2]                             -- Output: True
    print $ myordered [1,1]                             -- Output: True
    print $ myordered [2,1]                             -- Output: False
    print $ myordered "abcdefg"                         -- Output: True
    print $ myordered "ba"                              -- Output: False
    print $ "myordered_pm"
    print $ myordered_pm ([] :: [Int])                  -- Output: True
    print $ myordered_pm [1]                            -- Output: True
    print $ myordered_pm  [1,2]                         -- Output: True
    print $ myordered_pm  [1,1]                         -- Output: True
    print $ myordered_pm  [2,1]                         -- Output: False
    print $ myordered_pm  "abcdefg"                     -- Output: True
    print $ myordered_pm  "ba"                          -- Output: False

    let inputString = "046352;Moe;Howard;32;11;Y;E;G;Y;500"
    print $ splitBySemicolon inputString
    let fees = computeFees inputString
    print fees

    let inputString = "172458;Larissa;Pine;20;12;Y;A;W;N"
    print $ splitBySemicolon inputString
    let fees = computeFees inputString
    print fees

    let inputString = "611030;Dorothy;Gale;48;9;N;C;S"
    print $ splitBySemicolon inputString
    let fees = computeFees inputString
    print fees

    let inputString = "498545;Frank;Baum;68;3;N;S"
    print $ splitBySemicolon inputString
    let fees = computeFees inputString
    print fees

    let inputString = "649231;John;Fogerty;78;3;Y;S;G;N"
    print $ splitBySemicolon inputString
    let fees = computeFees inputString
    print fees

    let inputString = "832181;Paul;Simon;83;12;Y;S;P;Y;500"
    print $ splitBySemicolon inputString
    let fees = computeFees inputString
    print fees

    let inputString = "234423;Paul;McCartney;81;15;N;S"
    print $ splitBySemicolon inputString
    let fees = computeFees inputString
    print fees

    let inputString = "512230;Art;Garfunkel;42;19;Y;A;G;Y;2345"
    print $ splitBySemicolon inputString
    let fees = computeFees inputString
    print fees
-} 