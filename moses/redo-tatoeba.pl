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

open(LINKS, "<", "links.csv");
open(SENTS, "<", "sentences.csv");

binmode(LINKS, ":utf8");
binmode(SENTS, ":utf8");
binmode(STDOUT, ":utf8");

my $src = 'eng';
my $trg = 'gle';

my %srcsent = ();
my %trgsent = ();

while(<SENTS>) {
    chomp;
    my ($id, $lang, $sent) = split /\t/;
    next if ($id == 2828470); # ought to be glg -- Galician
    if ($lang eq $src) {
        $srcsent{$id} = $sent;
    } elsif ($lang eq $trg) {
        $trgsent{$id} = $sent;
    } else {
        next;
    }
}

while(<LINKS>) {
    chomp;
    my ($a, $b) = split /\t/;
    if (exists $srcsent{$a} && exists $trgsent{$b}) {
        print "$srcsent{$a}\t$trgsent{$b}\n";
    } elsif (exists $srcsent{$b} && exists $trgsent{$a}) {
        print "$srcsent{$b}\t$trgsent{$a}\n";
    } else {
        next;
    }
}
