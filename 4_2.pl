#!perl

use strict;
use warnings;

my $min = 248345;
my $max = 746315;

my $count;

for ( $min .. $max ) {
	my @digits = split //,$_;

	my $double = 0;
	my $ascend = 0;

	# do stuff
	
	for ( 1..5 ) {
		if ( $digits[$_] < $digits[$_-1] ) {
			$ascend = 1;
			last;
		}

		if ( not $double and $digits[$_] == $digits[$_-1] ) {
			$double = $digits[$_];
		}

		if ( $_ > 1 and $double == $digits[$_] and $digits[$_-2] == $digits[$_] ) {
			$double = 0;
		}
	}

	$count++ if $double and not $ascend;
}

print "count is $count";

