{-# LANGUAGE BangPatterns #-}

-- Joe Jevnik
-- 15.11.2013
-- http://domino.research.ibm.com/Comm/wwwr_ponder.nsf/Challenges/February2011.html
-- IBM feb 2011

import Data.Char (digitToInt,intToDigit)
import Data.Word

-- Returns True if n is a flippable number.
-- Returns False if n is not flippable.
is_flippable :: (Integral a,Show a,Read a) => a -> Bool
is_flippable n = all (\d -> digitToInt d `elem` [0,1,2,5,6,8,9]) $ show n

-- A list of all of the pairs that can be used to make a flippable palindrome.
pairs :: [(Word8,Word8)]
pairs = [(0,0),(1,1),(2,2),(5,5),(6,9),(8,8),(9,6)]

-- Finds the number, returns it as a list of digirs.
-- Seeds the recursion with the base list, then calls make larger lists by
-- checking all possible palindromic flippables.
-- WARNING: Does not terminate and uses ~7gb of ram after a bit of time.
find_n :: IO [Word8]
find_n = find_n' [[1],[2],[5],[8],[1,1],[2,2],[5,5],[6,9],[8,8],[9,6]]
  where
      find_n' !ns
          | (not . null) (ms ns) = return $ head (ms ns)
          | otherwise = print (length ns)
                        >> find_n' [a:n ++ [b] | n <- ns, (a,b) <- pairs]
      ms !ns = filter is_found ns
      is_found !m = let n = (read . concatMap show) m
                   in n `rem` 2011 == 0 && is_flippable (n^2)

-- Print the answer.
main :: IO ()
main = find_n >>= print
