import strutils
import sequtils
import strformat
import options

let sample = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
"""

# let input =  sample
let input =  readFile("input")

type
  Seeds = seq[int]

proc parseSeedsBlock(blk: string): Seeds =
  let parts = blk.split ": "
  assert(parts[0] == "seeds", "***No 'seeds' block***")
  var seedsStrs = parts[1].split " "
  return seedsStrs.map parseInt

type
  Range = tuple
    dest: int
    start: int
    len: int

  Map = tuple
    fromCat: string
    toCat: string
    ranges: seq[Range]


proc parseMapBlock(blk: string): Map =
  let lines = blk.splitLines

  var i = 0
  for line in lines.items:
    if line == "":
      continue
    if i==0:

      let parts = line.split " "
      assert(parts[1] == "map:", "***No 'map' block (\"map\" missing in header)***")

      let convStrs = parts[0].split "-"
      assert(convStrs[1] == "to", "***No 'map' block (\"to\" missing in header)***")
      result.fromCat = convStrs[0]
      result.toCat = convStrs[2]

    else:

      let numStrs = line.split " "
      try:
        let nums:seq[int] = numStrs.map parseInt
        assert(nums.len == 3, "***No 'map' block (Range line not with exactly 3 number) ***")
        let range:Range = (dest: nums[0], start: nums[1], len: nums[2])
        result.ranges.add range
      except ValueError:
        echo &"*** Could not parse: '{line}' ***"
        raise

    i = i + 1

proc applyRange(range: Range, srcNum: int): Option[int] =
  # Map a source num to the destination for a given range
  # Returns the number only when a conversion happens, else wise none
  if srcNum >= range.start and srcNum < range.start + range.len:
    result = some(srcNum + range.dest - range.start)

# proc applyMap (map: Map, srcNum: int): int =
#   # Use map to calculate the destination num from a given srcNum
#   var mappedSoFar = none(int)
#   for range in map.ranges:
#     let mapped = applyRange(range, srcNum)
#     if mapped.isSome:
#       assert(mappedSofar.isNone, &"***Map range {range} is overlapping with a previous range ***")
#       mappedSoFar = mapped
#   if mappedSoFar.isSome:
#     return mappedSoFar.get
#   else:
#     return srcNum


var maps: seq[Map]

proc findMapByFromCat(allMaps: seq[Map], fromCat: string): int =
  ## Returns the first index of `item` in `a` or -1 if not found.
  result = 0
  for i in items(allMaps):
    if i.fromCat == fromCat: return
    inc(result)
  result = -1

proc gotoNextMap(allMaps: seq[Map], currMap: Map): Option[Map] =
  ## Return the next Map in the list
  let toIdx = findMapByFromCat(allMaps, currMap.toCat)
  return  if toIdx == -1:
            none(Map)
          else:
            some(allMaps[toIdx])

type
  CalcList = seq[Map]

#
# Main
#

# Make text into "blocks"
let blks = input.split "\n\n"
var seeds: seq[int]

# Parse the blocks: one Seed Block, rest are Map Blocks
var i = 0
for blk in blks:
  if i==0:
    seeds = parseSeedsBlock(blk)
  else:
    maps.add parseMapBlock(blk)
  i = i + 1

# Calculate the list of sequential maps to be used for location calculation

var calcList: CalcList

let startMapIdx = findMapByFromCat(maps, "seed" )
assert(startMapIdx >= 0, "***No startMap with from categry 'seed' ***")

var map = maps[startMapIdx]
while true:
  calcList.add map
  let possiblyMap = gotoNextMap(maps, map)
  if possiblyMap.isNone:
    break
  else:
    map = get possiblyMap

var mapToApply: Map

proc applyMap (srcNum: int): int =
  # Use map to calculate the destination num from a given srcNum
  #
  # Attention: Uses the global mapToApply (because of troubles using map:Map as parameter!
  let map = mapToApply
  var mappedSoFar = none(int)
  for range in map.ranges:
    let mapped = applyRange(range, srcNum)
    if mapped.isSome:
      assert(mappedSofar.isNone, &"***Map range {range} is overlapping with a previous range ***")
      mappedSoFar = mapped
  if mappedSoFar.isSome:
    result = mappedSoFar.get
  else:
    result = srcNum

proc seed2location(seed: int): int =
  # Calculate from a seed number through all maps in calcList the location
  #
  # Attention: Uses the global calcList (beacuse than I can use the map function without currying)
  result = seed
  for map in calcList:
    mapToApply = map
    result = applyMap (result)


let locations = seeds.map seed2location
echo locations
echo min(locations)
