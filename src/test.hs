-- IBM feb 2011

import Data.Char (digitToInt,intToDigit)
import Control.Applicative ((<*>))


is_valid :: (Integral a,Show a) => a -> Bool
is_valid n = let fs = map digitToInt $ show n
             in and (map (`elem` [1,2,5,6,8,9]) fs)
                    && (is_palandrome $ map flip_digit fs)
  where
      is_palandrome :: [Int] -> Bool
      is_palandrome n = reverse n == n


flip_digit :: Int -> Int
flip_digit 1 = 1
flip_digit 2 = 2
flip_digit 5 = 5
flip_digit 6 = 9
flip_digit 8 = 8
flip_digit 9 = 6
flip_digit _ = error "Not flippable"

flip_int :: (Integral a,Show a,Read a) => a -> a
flip_int n
    | and (map (`elem` [1,2,5,6,8,9]) $ map digitToInt $ show n)
        = read $ map (intToDigit . flip_digit . digitToInt) $ show n
    | otherwise = 0

flipables :: Integral a => [a]
flipables = [1]

find_n :: Integer
find_n = head [n | n <- flippables
              , flip_int n == n && is_valid n && is_valid (n^2)]
