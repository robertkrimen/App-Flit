package App::Flit::Project::Static;

use Any::Moose;

extends qw/ App::Flit::Project /;

sub load {
    my $self = shift;
    my %project = @_;
    return $self->new( %project );
}

1;
