package Wire;
use Moose;

has nodes => (
	is => 'ro',
	isa => 'ArrayRef[Node]',
	builder => '_create_route',
	lazy => 1,
	required => 1,
);

has definition => (
	is => 'ro',
	isa => 'Str',
	required => 1,
);


sub _create_route {
	my $self = shift;
	my @runs = split ",", $self->definition;
	
	my @nodes;

	my $current_node = Node->new( x => 0, y => 0 );

	for ( @runs ) {
		push @nodes, _build_run( $_, $current_node );
		$current_node = $nodes[-1];
	};

	return \@nodes;
}

sub _build_run {
	my $run = shift;
	my ( $direction, $distance ) = split //, $run, 2;
	my $current_node = shift;
	my @nodes;

	for ( 1 .. $distance ) {
		my $next_node = $current_node->next( $direction );
		push @nodes, $next_node;
		$current_node = $next_node;
	}
	return @nodes;
}

no Moose;
__PACKAGE__->meta->make_immutable;
