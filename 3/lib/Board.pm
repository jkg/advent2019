package Board;
use Moose;

has wires => (
	is => 'rw',
	isa => 'HashRef[Wire]',
	default => sub { {} },
);

has dict => (
	is => 'rw',
	isa => 'HashRef[HashRef]',
	default => sub { {} },
);

sub add_wire {
	my $self = shift;
	my $definition = shift;
	my $name = shift;

	my $wire = Wire->new( definition => $definition );
	$self->wires->{$name} = $wire;

	foreach my $node ( @{$wire->nodes} ) {
		my $key = join "_", ( $node->x, $node->y );
		$self->dict->{$key}{$name} = 1;
	}
}

no Moose;
__PACKAGE__->meta->make_immutable;
