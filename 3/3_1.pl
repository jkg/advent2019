#!perl

use lib 'lib/';
use strict;
use warnings;
use Modern::Perl;

use Wire;
use Node;

my $start = Node->new( x=>0, y=>0 );

my $definition = <>;
chomp;
my $wire1 = Wire->new( definition => $definition );


say "wire 1 has " . scalar @{ $wire1->nodes };

$definition = <>;
chomp;
my $wire2 = Wire->new( definition => $definition );

say "wire 2 has " . scalar @{ $wire2->nodes };

my $minimum_distance = undef;

for my $node1 ( @{ $wire1->nodes } ) {
	for my $node2 ( @{ $wire2->nodes } ) {

		#		say "comparing " . join (" ", $node1->x, $node1->y, $node2->x, $node2->y );


		if ( $node1->crosses($node2) ) {
			say "found a cross at " . $node1->x . "," . $node1->y;
			my $distance = $node1->distance_to( $start );
			say "distance is $distance";
			$minimum_distance = $distance 
				unless defined $minimum_distance and $distance > $minimum_distance;
		}
	}
}

say "minimum distance is: $minimum_distance";
