## Day 7: Rank Hands of Cards Than Mix It All Up With a Joker

### Solved in Java

The classic Java language can do it all, but it is super verbose! Even solving the first challenge alone needs 187 lines of code (excluding tests). Also, the directory structure I had to setup is both rigid and  elaborate for such a small program.[^00]

Despite the fact that I code in Java for a living I had to look up a few idioms, because similar things are not always handled similarly.[^0] 
From the perspea programm flow 
Also, this is the first challenge where I utilised unit tests. The core logic of `getType()` (which calculates the type of a hand) seemed to be a bit more complicated, so I thought tests are a good help here. However not knowing how to make debug `print` statements play well with the _JUnit 5_ testing framework[^1] I still used quite often a main to first implement a function, before I added it to the tests.

For the second challenge it  proved very useful to have the tests, because I changed the structure a little bit so that I could derive the `JokerHand` class from the `Hand` class and overwrite only the two methods `getOrderedCards()` and `getType()` for the changed ranking functionality.

**Bottom line:** It was not much fun to solve this puzzles in Java. The verbosity due to no type inference feels antiquated and some how _Java does not inspire_ (me) _to find elegant solutions_.

  [^00]: I did not easily manage to access the input files from the top directory. -- I had to move them into the source directory, so that teh I could `getResource()` use on the `ClassLoader` instance.

  [^0]: I'm thinking of the `length` property of arrays vs. the`size()` method of `ArrayList` objects, for example...
  [^1]: For me Junit always eat the output of all `System.out.print` lines...
