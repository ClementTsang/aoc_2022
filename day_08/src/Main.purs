module Main where

import Prelude
import Data.Array (foldl, length, range, (!!))
import Data.Int (fromString, toStringAs)
import Data.Int as Radix
import Data.Maybe (fromMaybe)
import Data.Ord (abs)
import Data.String.Utils (lines, toCharArray)
import Effect (Effect)
import Effect.Console (log)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)
import Node.Process (argv)

treeBigger :: Array (Array Int) -> Int -> Int -> Int -> Boolean
treeBigger grid x y tree = do
  (fromMaybe 0 ((fromMaybe [] (grid !! y)) !! x)) >= tree

biggerTreesVert :: Array (Array Int) -> Array (Int) -> Int -> Int -> Int
biggerTreesVert grid toCheck x tree = do
  foldl
    ( \acc y ->
        if treeBigger grid x y tree then
          acc + 1
        else
          acc
    )
    0
    toCheck

biggerTreesHori :: Array (Array Int) -> Array (Int) -> Int -> Int -> Int
biggerTreesHori grid toCheck y tree = do
  foldl
    ( \acc x ->
        if treeBigger grid x y tree then
          acc + 1
        else
          acc
    )
    0
    toCheck

-- We expect the range goes from outer -> in, towards the tree in question.
treesUntilFirstBiggerVert :: Array (Array Int) -> Array (Int) -> Int -> Int -> Int -> Int
treesUntilFirstBiggerVert grid toCheck treeY x tree = do
  let
    outer = fromMaybe 0 (toCheck !! 0)
  abs
    ( treeY
        - ( foldl
              ( \acc y ->
                  if treeBigger grid x y tree then
                    y
                  else
                    acc
              )
              outer
              toCheck
          )
    )

-- We expect the range goes from outer -> in, towards the tree in question.
treesUntilFirstBiggerHori :: Array (Array Int) -> Array (Int) -> Int -> Int -> Int -> Int
treesUntilFirstBiggerHori grid toCheck y treeX tree = do
  let
    outer = fromMaybe 0 (toCheck !! 0)
  abs
    ( treeX
        - ( foldl
              ( \acc x ->
                  if treeBigger grid x y tree then
                    x
                  else
                    acc
              )
              outer
              toCheck
          )
    )

partOne :: Array (Array Int) -> Int -> Int -> Int -> Int -> Int -> Int
partOne grid maxHeight maxWidth i j count = do
  let
    tree = fromMaybe 0 ((fromMaybe [] (grid !! i)) !! j)

    newCount =
      if i == 0 || i == (maxHeight - 1) || j == 0 || j == (maxWidth - 1) then
        count + 1
      else if ((biggerTreesVert grid (if i > 0 then range 0 (i - 1) else []) j tree) == 0)
        || ((biggerTreesVert grid (if i < (maxHeight - 1) then range (maxHeight - 1) (i + 1) else []) j tree) == 0)
        || ((biggerTreesHori grid (if j > 0 then range 0 (j - 1) else []) i tree) == 0)
        || ((biggerTreesHori grid (if j < (maxWidth - 1) then range (maxWidth - 1) (j + 1) else []) i tree) == 0) then
        count + 1
      else
        count
  if j + 1 == maxWidth then
    if i + 1 == maxHeight then
      newCount
    else
      partOne grid maxHeight maxWidth (i + 1) 0 newCount
  else
    partOne grid maxHeight maxWidth i (j + 1) newCount

partTwo :: Array (Array Int) -> Int -> Int -> Int -> Int -> Int -> Int
partTwo grid maxHeight maxWidth i j best = do
  let
    tree = fromMaybe 0 ((fromMaybe [] (grid !! i)) !! j)

    newBest =
      if i == 0 || i == (maxHeight - 1) || j == 0 || j == (maxWidth - 1) then
        best
      else
        max best
          ( (treesUntilFirstBiggerVert grid (if i > 0 then range 0 (i - 1) else []) i j tree)
              * (treesUntilFirstBiggerVert grid (if i < (maxHeight - 1) then range (maxHeight - 1) (i + 1) else []) i j tree)
              * (treesUntilFirstBiggerHori grid (if j > 0 then range 0 (j - 1) else []) i j tree)
              * (treesUntilFirstBiggerHori grid (if j < (maxWidth - 1) then range (maxWidth - 1) (j + 1) else []) i j tree)
          )
  if j + 1 == maxWidth then
    if i + 1 == maxHeight then
      newBest
    else
      partTwo grid maxHeight maxWidth (i + 1) 0 newBest
  else
    partTwo grid maxHeight maxWidth i (j + 1) newBest

main :: Effect Unit
main = do
  args <- argv
  let
    filePath = fromMaybe "input.txt" (args !! 3)
  log $ "Using file path " <> filePath <> "\n"
  fileContents <- (readTextFile UTF8 filePath)
  let
    grid = map (map \i -> fromMaybe 0 (fromString i)) (map toCharArray (lines fileContents))

    gridWidth = length grid

    gridHeight = length (fromMaybe [] (grid !! 0))
  log $ "Part 1: " <> toStringAs Radix.decimal (partOne grid gridHeight gridWidth 0 0 0)
  log $ "Part 2: " <> toStringAs Radix.decimal (partTwo grid gridHeight gridWidth 0 0 0)
