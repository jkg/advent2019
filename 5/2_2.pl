#!perl

use strict; use warnings;
use Modern::Perl;
use Storable qw|dclone|;

our @initial_ram = split /,/, <>;

our $verbose = 0;

for my $noun ( 0..99 ) {
	for my $verb ( 0..99 ) { 
		my $result = execute( $noun, $verb );
		say $result if $verbose;

		if ( $result == 19690720 ) {
			say "noun: $noun, verb: $verb, result: " . (100 * $noun + $verb);
		}
	}
}


sub execute {
	my $pc = 0;
	my @ram = @{ dclone(\@initial_ram) };
	say "input state: " . join "-", @ram if $verbose;
	$ram[1] = shift;
	$ram[2] = shift;

	while (1) {
		if ( $ram[$pc] == 1 ) {
			$ram[$ram[$pc+3]] = $ram[$ram[$pc+1]] + $ram[$ram[$pc+2]];
			$pc+=4;
			next;
		} elsif ( $ram[$pc] == 2 ) {
			$ram[$ram[$pc+3]] = $ram[$ram[$pc+1]] * $ram[$ram[$pc+2]];
			$pc+=4;
			next;
		} elsif ( $ram[$pc] == 99 ) {
			last;
		} else {
			die "Unexpected opcode found at position $pc";
		}
	}
	say "final state: " . join "-", @ram if $verbose;

	return $ram[0];
}


