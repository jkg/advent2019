#!perl

use lib 'lib/';
use strict;
use warnings;
use Modern::Perl;

use Wire;
use Node;
use Board;

my $board = Board->new;

my $n = 0;
while ( my $definition = <> ) {
	$n++;
	$board->add_wire( $definition, "wire$n" );
}

my $minimum_distance = 999999999;
for my $node ( @{ $board->wires->{wire1}->nodes } ) {

	my $key = join "_", ( $node->x, $node->y );
	#	say "checking $key";
	if ( $board->dict->{$key}->{wire2} ) {
		say "found a cross at $key";

		my $dist1 = $board->wires->{wire1}->distance_to( $node );
		my $dist2 = $board->wires->{wire2}->distance_to( $node );

		my $distance = $dist1 + $dist2;
		$minimum_distance = $distance unless $distance >= $minimum_distance;
	}
}

say "minimum distance to a cross from 0,0 is $minimum_distance";

