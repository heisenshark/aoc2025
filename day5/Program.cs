using System.IO;

bool IsWithin(long value, long minimum, long maximum)
{
    return value >= minimum && value <= maximum;
}

var file = File.Open("data.txt", FileMode.Open);
var reader = new StreamReader(file);
var currentLine = "";
var rangesList = new List<(long,long)>();
var idList= new List<long>();

while (!reader.EndOfStream)
{
    currentLine = reader.ReadLine();
    if(currentLine==null||currentLine=="") break;
    var split = currentLine.Split('-');
    var start = long.Parse(split[0]);
    var end = long.Parse(split[1]);
    rangesList.Add((start, end));  
}

while (!reader.EndOfStream)
{
    currentLine = reader.ReadLine();
    if(currentLine!=null||currentLine=="")
        idList.Add(long.Parse(currentLine));  
}
rangesList.Sort((a,b)=> a.Item1.CompareTo(b.Item1));

var normalizedRangesList = new List<(long,long)>();
var currentRange = rangesList[0];
for (int i = 1; i < rangesList.Count; i++)
{
    if(currentRange.Item2>=rangesList[i].Item1-1 )
    {
        if(rangesList[i].Item2<= currentRange.Item2)
            continue;
        currentRange.Item2 = rangesList[i].Item2;
    }
    else
    {
        normalizedRangesList.Add(currentRange);
        currentRange = rangesList[i];
    }
}
normalizedRangesList.Add(currentRange);

long count = 0;
foreach (var item in idList)
{
    foreach (var range in rangesList)
    {
        var (low,high) = range;
        if(IsWithin(item, low, high))
        {
            count++;
            break;
        }
    }
}

long part2Count = 0;
foreach(var range in normalizedRangesList)
{
    part2Count += range.Item2 - range.Item1+1;
}

Console.WriteLine(count);
Console.WriteLine(part2Count);
file.Close();