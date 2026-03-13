my $contents = "data.txt".IO.slurp;
my @dupa = split("\n",$contents);
my $argument_arrays = [];
for @dupa -> $line {
    my $arguments_line = split(/\s+/,trim($line) );
    $argument_arrays.append($arguments_line)
} 

my $vava = $argument_arrays[0].elems;
my $aaaa = $argument_arrays.elems -2;

my $total_sum = 0;
for ^$vava -> $i {
    my $sum = $argument_arrays.head[$i];
    my $op = $argument_arrays.tail[$i];
    for 1..$aaaa -> $j {
        {$sum = $sum + $argument_arrays[$j][$i];} if $op eq '+';
        {$sum = $sum * $argument_arrays[$j][$i];} if $op eq '*';
    }
    $total_sum += $sum;
}
say $total_sum;