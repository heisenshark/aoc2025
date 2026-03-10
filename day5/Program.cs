using System.IO;

Console.WriteLine("Hello, World!");
Console.WriteLine("test elo");

var file = File.Open("data.txt", FileMode.Open);
var reader = new StreamReader(file);
var currentLine = "";
var lineList = new List<string>();

while (!reader.EndOfStream&& currentLine !="\n")
{
    currentLine = reader.ReadLine();
    if(currentLine!=null)
        lineList.Add(currentLine);  
}

Console.WriteLine(lineList);  
file.Close();