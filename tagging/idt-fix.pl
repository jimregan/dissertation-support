#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode STDIN, ":utf8";
binmode STDERR, ":utf8";
binmode STDOUT, ":utf8";

while(<>) {
	chomp;
	s/\r//g;
	next if(/^$/);
	my @a = split/\t/;
	if($a[0] eq '1') {
		print "||\t||\n||\t||\n";
	}
	my $surface = $a[1];
	my $lemma = $a[2];
	my $tags = '';
	if($a[3] eq $a[4] || $a[4] eq '_') {
		$tags = "+" . $a[3];
	} else {
		$tags = "+" . $a[3] . "+" . $a[4];
	}
	if($a[5] ne '_') {
		$tags .= "+$a[5]";
	}
	if($tags eq '+.') {
		$tags = '+Punct+Fin';
	}
	#print $surface . "\t" . $lemma . "\t" . $tags . "\n";
	print $surface . "\t" . $tags . "\n";
}


