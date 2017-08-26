#!/usr/bin/perl

BEGIN{
print '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
print "<dictionary>\n";
}

my %forms = ();
while(<>) {
    chomp;
    next if(/\+Event/);
    next if(/\+XMLTag/);
    my @line = split /\t/;
    my $text = $line[0];
    $text =~ s/\+/\t/;
    $text =~ s/\+/:/g;
    my @nline = split/\t/, $text;
    if(exists $forms{$line[1]}) {
        $forms{$line[1]} .= " $nline[1]";
    } else {
        $forms{$line[1]} = $nline[1];
    }
}

for my $k (keys %forms) {
    $k =~ s/&/&amp;/;
    print "<entry tags=\"$forms{$k}\">\n<token>$k</token>\n</entry>\n";
}

END{
print '</dictionary>';
}