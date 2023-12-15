## Day 4: Winning numbers score points which adds up

### Solved in Haskell

Writing Haskell was surprisingly efficient: 

The IO part is minimal[^1], the parsing of the input was reasonably easy and the calculations simple -- once I understood that the points of a card  solely depend on the numbers in the _intersection_ of winning numbers and my numbers. In the source this boils down to the line

```haskell
foundNums = (winOfCard c) `intersect` (mineOfCard c)
```

  [^1]: It is particularity important that I/O is _separate_ from the core rest of the program. Therefore  essentially everything suits Haskell's pure style.

 Due to the strong static typing in Haskell I had to make early decisions about the data structure. Using a record 

```Haskell
data Card = Card {
  win :: [Int]
, mine :: [Int]
} deriving Show
```

as the core structure was maybe not the most elegant decision, but it worked.

**Note:** I solved -- so far -- only the first challenge.


**Bottom line:** Haskell certainly calls for a different way of thinking than imperative languages, but all in all it is pretty well suited to these puzzles.
