{-# LANGUAGE BangPatterns #-}
-- http://domino.research.ibm.com/Comm/wwwr_ponder.nsf/Challenges/February2011.html
-- IBM feb 2011

import Data.Char (digitToInt,intToDigit)

--is_flippable :: (Integral a,Show a,Read a) => a -> Bool
is_flippable n = all (\d -> digitToInt d `elem` [1,2,5,6,8,9]) $ show n

--pairs :: (Integral a,Show a,Read a) => [(a,a)]
pairs = [(1,1),(2,2),(5,5),(6,9),(8,8),(9,6)]

--candidates :: (Integral a,Show a,Read a) => [[a]]
candidates = bld [[1],[2],[5],[8],[11],[22],[55],[69],[88],[96]]
  where
      bld ns = ns ++ bld [a:n ++ [b] | n <- ns, (a,b) <- pairs]


--find_n :: (Integral a,Show a,Read a) => a
find_n = find_n' [[1],[2],[5],[8],[11],[22],[55],[69],[88],[96]]
  where
      find_n' !ns
          | (not . null) (ms ns) = head (ms ns)
          | otherwise = find_n' [a:n ++ [b] | n <- ns, (a,b) <- pairs]
      ms !ns = filter is_found ns
      is_found !m = let n = (read . concatMap show) m
                   in n `rem` 2011 == 0 && is_flippable (n^2)

main :: IO ()
main = print find_n
