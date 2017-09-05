#!/usr/bin/perl
# The MIT License (MIT)
#
# Copyright (c) 2017 Jim O'Regan
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

use warnings;
use strict;
use utf8;
use List::MoreUtils qw(uniq);

BEGIN{
print '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
print "<dictionary>\n";
}

my %forms = ();
my $train = $ARGV[0];
open my $fh, '<', $train or die "$!";
binmode STDIN, ":utf8";
binmode $fh, ":utf8";
binmode STDOUT, ":utf8";


while(<$fh>) {
    chomp;
    for my $tok (split/ /) {
        my @wrd = split/_/, $tok;
        if(exists $forms{$wrd[0]}) {
            $forms{$wrd[0]} .= " $wrd[1]";
        } else {
            $forms{$wrd[0]} = $wrd[1];
        }
    }
}

while(<STDIN>) {
    chomp;
    next if(/\+Event/);
    next if(/\+XMLTag/);
    next if(/^$/);
    next if(/^\s*$/);
    my @line = split /\t/;
    my $text = $line[0];
    $text =~ s/\+/\t/;
    $text =~ s/\+/:/g;
    my @nline = split/\t/, $text;
    if($#line != 1) {
        print STDERR $_;
    }
    if($line[0] eq '++Num+Op') {
        $forms{'+'} = 'Num:Op';
    } elsif(exists $forms{$line[1]}) {
        $forms{$line[1]} .= " $nline[1]";
    } else {
        $forms{$line[1]} = $nline[1];
    }
}

for my $k (keys %forms) {
    if(!exists $forms{$k}) {
        print STDERR "Missing: $k\n";
    }
    my $outraw = $forms{$k};
    $k =~ s/&/&amp;/;
    my @outarr = split/ /, $outraw;
    my $outreal = $outraw;
    if($#outarr > 1) {
        my @forms = uniq ;
        my $outreal = join(" ", @forms);
    }
    print "<entry tags=\"$outreal\">\n<token>$k</token>\n</entry>\n";
}

END{
print '</dictionary>';
}
