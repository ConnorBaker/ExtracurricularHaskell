{-# OPTIONS_GHC -Weverything -Wno-missing-import-lists #-}

module Solutions
    ( helloWorld
    , facRecursive
    , sumdown
    , (^)
    , euclid
    , and
    , concat
    , replicate
    , (!!)
    , elem
    , merge
    , halve
    , msort
    , sumOfList
    , takeFromList
    , lastElem
    ) where

-- Allows us to avoid a namespace conflict with our own implementation
import Prelude hiding
    ( (^)
    , and
    , concat
    , replicate
    , (!!)
    , elem
    )

-- #1
facRecursive :: Int -> Int
facRecursive n
    | n < 0     = 0
    | n == 0    = 1
    | otherwise = n * facRecursive (n - 1)

-- #2
sumdown :: Int -> Int
sumdown 0 = 0
sumdown n = n + sumdown (n - 1)

-- #3
-- Assumes that the answer is computable; no 0^0
(^) :: Int -> Int -> Int
0 ^ _ = 0
_ ^ 0 = 1
n ^ m = n * (n ^ (m - 1))

-- #4
euclid :: Int -> Int -> Int
euclid n m 
    | n == m = n
    | n >  m = euclid m (n - m)
    | n <  m = euclid n (m - n)

-- #6 Part a
and :: [Bool] -> Bool
and []        = True
and (False:_) = False
and (_:xs)    = and xs

-- #6 Part b
concat :: [[a]] -> [a]
concat []       = []
concat (xs:xss) = xs ++ concat xss

-- #6 Part c
replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate n a = [a] ++ replicate (n - 1) a

-- #6 Part d
-- For simplicity, assume that the index is valid and that
-- the array is non-empty
(!!) :: [a] -> Int -> a
(x:_)  !! 0 = x
(_:xs) !! n = xs !! (n - 1)

-- #6 Part e
elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
-- Note: ys can be [] which is why (y:ys) matches singletons
elem x (y:ys)
    | x == y = True
    | x /= y = elem x ys

-- #7
merge :: Ord a => [a] -> [a] -> [a]
merge [] y'     = y'
merge x' []     = x'
merge x'@(x:xs) y'@(y:ys)
    | (x <= y)  = x : merge xs y'
    | otherwise = y : merge x' ys

-- #8
halve :: [a] -> ([a],[a])
halve xs = splitAt (div (length xs) 2) xs

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge (msort a) (msort b)
    where a = fst $ halve xs
          b = snd $ halve xs

-- #9 Part a
sumOfList :: Num a => [a] -> a
sumOfList []     = 0
sumOfList (x:xs) = x + (sumOfList xs)

-- #9 Part b
takeFromList :: Int -> [a] -> [a]
takeFromList _ []     = []
takeFromList 0 _      = []
takeFromList n (x:xs) = x : takeFromList (n - 1) xs

-- #9 Part c
lastElem :: [a] -> a
lastElem [x]    = x
lastElem (_:xs) = lastElem xs
lastElem []     = error "List is empty!"

helloWorld :: IO ()
helloWorld = putStrLn "Chapter 6 Exercises"
