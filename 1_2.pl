#!perl

use strict; use warnings;
use feature 'say';

my $total_fuel = 0;

while(<>){
	my $mass = $_;
	$total_fuel += fuel_for_module( $mass );
}

say $total_fuel;

sub fuel_for_mass
{
	my $mass = shift;
	my $fuel = int($mass/3)-2;
	return $fuel > 0 ? $fuel : 0;
}

sub fuel_for_module
{
	my $mass = shift;
	my $fuel = 0;
	while ( my $more_fuel = fuel_for_mass( $mass ) ) {
		$fuel += $more_fuel;
		$mass = $more_fuel;
	}
	return $fuel;
}
