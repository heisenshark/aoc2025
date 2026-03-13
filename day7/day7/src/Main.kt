import java.io.File

fun main() {
    val f = File("data.txt");
    val lines = f.readLines();
    val startPos = lines[0].indexOf("S");
    val rep = mutableListOf(LongArray(lines[0].length));
    rep[0][startPos] = 1;
    var splitCount = 0;
    for (i in 1..<lines.size) {
        val last = rep[i - 1];
        rep.add(LongArray(lines[0].length));
        for (j in 0..<lines[0].length) {
            val lc = last[j];
            val c = lines[i][j];
            if (rep[i][j] > 0) {rep[i][j] += lc;continue;}
            when (c) {
                '.' -> {
                    rep[i][j] = lc;
                }
                '^' -> {
                    if (lc < 1) continue;
                    if (j - 1 >= 0)
                        rep[i][j - 1] +=lc;
                    if (j + 1 < lines[0].length)
                        rep[i][j + 1] +=lc;
                    splitCount++;
                }
            }
        }
    }
    println(splitCount);
    println(rep.last().reduce { acc, n -> acc + n })
}