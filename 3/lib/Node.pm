package Node;
use Moose;

has x => (
	is => 'ro',
	isa => 'Int',
);

has y => ( 
	is => 'ro',
	isa => 'Int',
);

sub distance_to {
	my $self = shift;
	my $other_node = shift;

	return undef unless $other_node->isa( 'Node' );

	my $taxicab_distance = abs($self->x - $other_node->x) + abs($self->y - $other_node->y);
	return $taxicab_distance;
}

sub crosses {
	my $self = shift;
	my $other_node = shift;
	return undef unless $other_node->isa('Node');

	return 1 if ( $self->x == $other_node->x and $self->y == $other_node->y );
	return 0;
}

sub next {
	my $self = shift;
	my $direction = shift;
	if ( $direction eq 'U' ) {
		return Node->new ( x => $self->x, y => $self->y + 1 );
	} elsif ( $direction eq 'R' ) {
		return Node->new ( x => $self->x + 1, y => $self->y );
	} elsif ( $direction eq 'D' ) {
		return Node->new ( x => $self->x, y => $self->y - 1 );
	} elsif ( $direction eq 'L' ) {
		return Node->new ( x => $self->x - 1, y => $self->y ); 
	} else {
		return undef;
	}
}

no Moose;
__PACKAGE__->meta->make_immutable;
