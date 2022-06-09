{- stack script
 --resolver lts-19.10
 --package random
-}

import System.Random

seed = 123

-- groupby :: Int -> [] ???
groupby n arr = takeWhile (not.null) (map (take n) (iterate (drop n) arr))

-- ?
randBool aseed = fst (randomR (0, 1) (mkStdGen aseed) :: (Int, StdGen)) == 0

rendercell :: Bool -> String
rendercell cell = if cell
  then "#"
  else " "

renderline :: [Bool] -> String
renderline = concatMap rendercell

renderboard :: [[Bool]] -> String
renderboard board = unlines $ map renderline board

liveordie :: [[Bool]] -> Int -> Int -> Bool
liveordie board row col = do
  let cell = board !! row !! col
  let be = board !! (row + 1) !! col
  let ab = board !! (row - 1) !! col
  let ri = board !! row !! (col + 1)
  let le = board !! row !! (col - 1)
  let tl = board !! (row - 1) !! (col - 1)
  let tr = board !! (row - 1) !! (col + 1)
  let bl = board !! (row + 1) !! (col - 1)
  let br = board !! (row + 1) !! (col + 1)

  let count = length (filter id [ri, tr, ab, tl, le, bl, be, br])

  if cell
    then count == 2 || count == 3
  else count == 3

-- mapLine :: Int -> [Bool] -> [Bool]
-- mapLine row line = map (liveordie board row) (zip [0..] line)

-- tick :: [[Bool]] -> [[Bool]]
-- tick board = map () (zip [0..] board)

-- ?
main = do
  let size = 10
  let board = groupby size (map randBool [seed..(seed - 1 + (size * size))])

  print $ zip [0..] board

  -- print $ liveordie board 1 1
  -- -- renderboard (tick board 1 1)

  -- putStr $ renderboard board
