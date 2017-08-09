#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode STDIN, ":utf8";
binmode STDERR, ":utf8";
binmode STDOUT, ":utf8";

my %unmwe = (
"a_lán" => [["a", "a", "Det:Poss:3P:Sg:Masc"], ["lán", "lán", "Noun:Masc:Com:Sg:Len"]],
"ar_ais" => [["ar", "ar", "Prep:Simp"], ["ais", "ais", "Subst:Noun:Sg"]],
"Ar_ais" => [["Ar", "ar", "Prep:Simp"], ["ais", "ais", "Subst:Noun:Sg"]],

);

while(<>) {
	chomp;
	s/\r//g;
	print "\n" if(/^$/);
	print "\n" if(/^#/);
	my @a = split/\t/;
	if($#a != 9) {
		print "\n";
		next;
	}
	my $surface = $a[1];
	my $lemma = $a[2];
	my $tags = '';
	if($a[3]) {
            if($a[4] && ($a[3] eq $a[4] || $a[4] eq '_')) {
                    $tags = "+" . $a[3];
            } else {
                    $tags = "+" . $a[3] . "+" . $a[4];
            }
        }
	if($a[5] && $a[5] ne '_') {
		$tags .= "+$a[5]";
	}
	if($tags eq '+.') {
		$tags = '+Punct+Fin';
	}
        $tags =~ s/\+//;
        $tags =~ s/\+/:/g;
	#print $surface . "\t" . $lemma . "\t" . $tags . "\n";
#	print $surface . "\t" . $tags . "\n";
        print "$a[0]\t$a[1]\t$a[2]\t$tags\t$a[4]\t$a[5]\t$a[6]\t$a[7]\t$a[8]\t$a[9]\n";
        if($a[1] =~ /_/) {
            print STDERR "$a[1]\n";
        }
}


