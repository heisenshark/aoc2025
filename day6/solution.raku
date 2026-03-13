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

my @column_lens = @dupa.tail.match(/[\+|\*]\s+<?[\*|\+]>|[\+|\*]\s+$/,:exhaustive).map(->$value {$value.chars});
my $current_pos = 0;

my $ii = 0;

my $total_sum2 = 0;
for @column_lens -> $l {
    my $ccc = $l-2;
    if $ii==@column_lens.elems-1 {$ccc+=1;}
    my $op = @dupa.tail.substr($current_pos,1);
    my $sum = 0;
    for 0..($ccc) -> $i {
        my $test = "";
        for 0..$aaaa -> $j {
            $test = $test ~ @dupa[$j].substr($current_pos+$i,1);
        }

        if $i == 0 {$sum += $test}
        else {
            {$sum = $sum + $test;} if $op eq '+';
            {$sum = $sum * $test;} if $op eq '*';
        }
    }

    $total_sum2+= $sum;
    $ii += 1;
    $current_pos+=$l;
}

say $total_sum2;