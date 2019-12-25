#!perl

use lib 'lib/';
use strict;
use warnings;
use Modern::Perl;

use Wire;
use Node;
use Board;

my $start = Node->new( x=>0, y=>0 );

my $board = Board->new;

my $n = 0;
while ( my $definition = <> ) {
	$n++;
	$board->add_wire( $definition, "wire$n" );
}

my $minimum_distance = undef;

my $minimum_distance = 999999999;
for my $node1 ( @{ $board->wires->{wire1}->nodes } ) {

	my $key = join "_", ( $node1->x, $node1->y );
	#	say "checking $key";
	if ( $board->dict->{$key}->{wire2} ) {
		say "found a cross at $key";
		my $distance = $node1->distance_to( $start );
		$minimum_distance = $distance unless $distance >= $minimum_distance;
	}
}

say "minimum distance to a cross from 0,0 is $minimum_distance";

