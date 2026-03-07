import std/strutils
import strutils

var text = """987654321111111
811111111111119
234234234234278
818181911112111"""

let filetext = readFile("input.txt")
text = filetext

proc cti(c:char):int = 
  return int(c) - int('0')

proc tenpower( power:int): int = 
  var base = 1
  for i in 1..power:
    base *= 10
  return base

proc figjopar(row:string,iterations:int):int = 
  if row.len < iterations:
    return 0

  var sum = 0
  var highest_pos = 0
  for iter in 1..iterations:
    for i in highest_pos..high(row)-(iterations-iter):
      var num = cti(row[i])
      if num > cti(row[highest_pos]):
        highest_pos=i
    sum += cti(row[highest_pos]) * tenpower(iterations - iter)
    highest_pos+=1
  return sum


when isMainModule:
  echo("Hello, World!");
  echo(text);
  let strs = rsplit(text,'\n')
  echo(strs)
  var solution1 = 0
  var solution2 = 0
  for i in strs:
    solution1 += figjopar(i,2)
    solution2 += figjopar(i,12)
  echo "Solution 1: ", solution1
  echo "Solution 2: ", solution2