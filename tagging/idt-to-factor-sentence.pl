#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my $sent = '';

while(<>) {
	chomp;
	s/^\s*$//;

	if(/\t/) {
		my @parts = split/\t/;
		if($sent eq '') {
			$sent = $parts[3];
		} else {
			$sent .= " $parts[3]";
		}
	} elsif(/^$/) {
		print "$sent\n";
		$sent = '';
	} else {
		print STDERR "$_\n";
	}
}
