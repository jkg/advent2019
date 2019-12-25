#!perl

use strict; use warnings;
use Modern::Perl;
use integer;
use feature 'say';

our $pc = 0;
our @ram = split /,/, <>;

while (1) {
	my $instruction = $ram[$pc] % 100;
	my @modes = reverse split //, $ram[$pc] / 100;

	if ( $ram[$pc] % 100 == 1 ) {
		add(@modes);
		$pc+=4;
		next;
	} elsif ( $ram[$pc] % 100 == 2 ) {
		mult(@modes);
		$pc+=4;
		next;
	} elsif ( $ram[$pc] % 100 == 3 ) {
		my $input = <>;
		store($input);
		$pc += 2;
	} elsif ( $ram[$pc] % 100 == 4 ) {
		output();
		$pc += 2;
	} elsif ( $ram[$pc] % 100 == 99 ) {
		last;
	} else {
		die "Unexpected opcode found at position $pc";
	}
}

sub add {
	my $mode1 = shift // 0;
	my $mode2 = shift // 0;
	my ( $first, $second, $output ) = @ram[$pc+1..$pc+3];

	$first = $ram[$first] unless $mode1;
	$second = $ram[$second] unless $mode2;

	$ram[$output] = $first + $second;
}

sub mult {
	my $mode1 = shift // 0;
	my $mode2 = shift // 0;
	my ( $first, $second, $output ) = @ram[$pc+1..$pc+3];

	$first = $ram[$first] unless $mode1;
	$second = $ram[$second] unless $mode2;

	$ram[$output] = $first * $second;
}

sub store {
	my $location = $ram[$pc+1];
	$ram[$location] = shift;
}

sub output {
	my $location = $ram[$pc+1];
	say $ram[$location];
}

