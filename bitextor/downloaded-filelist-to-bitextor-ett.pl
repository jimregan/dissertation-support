#!/usr/bin/perl

use warnings;
use strict;
use utf8;
use MIME::Base64 qw(encode_base64);

while(<>) {
	chomp;
	my $file = $_;
	$file =~ s/^\.\///;
	my $data;
	{
		print STDERR "File: $file " . length($file) . "\n";
		open my $fh, '<', $file or die "$!\n";
		local $/ = undef;
		$data = <$fh>;
		close $fh;
	}
	my $b64 = encode_base64($data, "");
	print "$b64\thttp://$file\n";
}
