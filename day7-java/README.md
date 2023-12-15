## Day 7: Rank Hands of Cards Than Mix It All Up With a Joker

### Solved in Java

The classic Java language can do it all, but it is super verbose! Even solving the first challenge alone needs 187 lines of  code (excluding tests). Despite the fact that I code in Java for a living I had look up a few idioms, because similar things are not always handled similarly.

Also this is the first challenge where I utilised tests. The core logic of `getType()` (which calulates the type of a hand) felt a bit more complicated, so I thought test are a good help here. However not knowing how to make debug `print` statements play well with the _JUnit 5_ testing framework[^1] I still used quite often a main to first implement a function.

  [^1]: For me Junit always eat the output of all `System.out.print` lines...
