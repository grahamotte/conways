{- stack script --resolver lts-19.10 -}

-- stack conway.hs

import System.Random
import Control.Concurrent

-- groupby :: Int -> [] ???
groupby n arr = takeWhile (not . null) (map (take n) (iterate (drop n) arr))

-- ???
randBool aseed = fst (randomR (0, 1) (mkStdGen aseed) :: (Int, StdGen)) == 0

rendercell :: Bool -> String
rendercell cell =
  if cell
    then "# "
    else ". "

renderline :: [Bool] -> String
renderline = concatMap rendercell

renderboard :: [[Bool]] -> String
renderboard board = unlines (map renderline board) ++ "\n"

liveordie :: [[Bool]] -> Int -> Int -> Bool
liveordie board row col = do
  let len = length board - 1
  let cell = board !! row !! col

  let be = if row + 1 > len then False else board !! (row + 1) !! col
  let ab = if row - 1 < 0 then False else board !! (row - 1) !! col
  let ri = if col + 1 > len then False else board !! row !! (col + 1)
  let le = if col - 1 < 0 then False else board !! row !! (col - 1)
  let tl = if row - 1 < 0 || col - 1 < 0 then False else board !! (row - 1) !! (col - 1)
  let tr = if row - 1 < 0 || col + 1 > len then False else board !! (row - 1) !! (col + 1)
  let bl = if row + 1 > len || col - 1 < 0 then False else board !! (row + 1) !! (col - 1)
  let br = if row + 1 > len || col + 1 > len then False else board !! (row + 1) !! (col + 1)

  let count = length (filter id [ri, tr, ab, tl, le, bl, be, br])

  if cell
    then count == 2 || count == 3
    else count == 3

tick :: [[Bool]] -> [[Bool]]
tick board = map (\r -> map (\c -> liveordie board r c) [0 .. length board - 1]) [0 .. length board - 1]

ticker boards 100 = return ()
ticker boards n = do
  threadDelay 100000
  putStr $ renderboard (boards !! n)
  ticker boards (n + 1)

main :: IO ()
main = do
  let seed = 123
  let size = 20
  let board = groupby size (map randBool [seed .. (seed - 1 + (size * size))])
  let boards = iterate tick board

  ticker boards 0

