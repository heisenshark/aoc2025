import std/strutils
import strutils

# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.



var text = """987654321111111
811111111111119
234234234234278
818181911112111"""

let filetext = readFile("input.txt")
text = filetext
proc figjo(ssss:string):int = 
  if ssss.len < 2:
    return 0
  var highest_pos = 0
  for i in low(ssss)..high(ssss)-1:
    var num = int(ssss[i]) - int('0')
    if num > int(ssss[highest_pos]) - int('0'):
      highest_pos=i
  var hpos2 = highest_pos + 1
  for i in hpos2..high(ssss):
    var num = int(ssss[i]) - int('0')
    if num > int(ssss[hpos2]) - int('0'):
      hpos2=i

  echo highest_pos, " ", hpos2
  return (int(ssss[highest_pos])-int('0'))*10 + int(ssss[hpos2])-int('0')

when isMainModule:
  echo("Hello, World!");
  echo(text);
  let strs = rsplit(text,'\n')
  echo(strs)
  var sum = 0
  for i in strs:
    echo figjo(i)
    sum += figjo(i)
  echo sum

