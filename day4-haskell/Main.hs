-- Day 4: Winning Cards
module Main where

import Data.List
import Data.List.Split
import Data.Char


data Card = Card {
  win :: [Int]
, mine :: [Int]
} deriving Show

winOfCard :: Card -> [Int]
winOfCard Card{ win=win, mine=_} =
  win

mineOfCard :: Card -> [Int]
mineOfCard Card{ win=_, mine=mine } =
  mine

--
-- Parsing input
-- 
numStr2Nums :: String -> [Int]
numStr2Nums s =
  map read nums
  where
    nums = filter (/="") $ splitOn " " s

line2Card :: String -> Card
line2Card line =
  Card { 
    win = numStr2Nums winStr
  , mine = numStr2Nums mineStr
  }
  where
    numPart = head $ tail $ splitOn ":" line
    numStrs = splitOn "|" numPart
    winStr = head numStrs
    mineStr = head $ tail numStrs

--
-- Calculations
--

card2Points :: Card -> Int
card2Points c =
  if cntFound >0 then    
    2 ^ (cntFound - 1)
  else
    0
  where
    foundNums = (winOfCard c) `intersect` (mineOfCard c)
    cntFound = length foundNums

lines2PointsList :: [String] -> [Int]
lines2PointsList lines =
  map (card2Points .line2Card) lines

-- | Calculate the sum of all points from the text of all cards ("the pile")
pileWealth :: String -> Int
pileWealth txt = 
  sum $ lines2PointsList (lines txt)

sample :: String
sample = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53\n\
         \Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19\n\
         \Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1\n\
         \Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83\n\
         \Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36\n\
         \Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11\n"

main :: IO ()
main = do
  input <- readFile "input"
  --let input = sample
  print $ pileWealth input
