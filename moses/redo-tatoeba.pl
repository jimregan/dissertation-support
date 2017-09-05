#!/usr/bin/perl

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
    next if ($id == 2828470); # ought to be por?, not gle
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
