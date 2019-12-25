#!perl

use strict; use warnings;
use Modern::Perl;

our $pc = 0;
our @ram = split /,/, <>;

# HOTFIX
$ram[1] = 12;
$ram[2] = 2;


while (1) {
	if ( $ram[$pc] == 1 ) {
		add();
		$pc+=4;
		next;
	} elsif ( $ram[$pc] == 2 ) {
		mult();
		$pc+=4;
		next;
	} elsif ( $ram[$pc] == 99 ) {
		last;
	} else {
		die "Unexpected opcode found at position $pc";
	}
}

use DDP;
p @ram;

sub add {
	my ( $first, $second, $output ) = @ram[$pc+1..$pc+3];
	$ram[$output] = $ram[$first] + $ram[$second];
}

sub mult {
    my ( $first, $second, $output ) = @ram[$pc+1..$pc+3];
    $ram[$output] = $ram[$first] * $ram[$second];
}


