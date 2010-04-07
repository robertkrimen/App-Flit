package App::Flit::Source;

use strict;
use warnings;

use App::Flit::Source::Data;

sub data {
    return App::Flit::Source::Data->data;
}

my $index;
sub index {
    my $self = shift;
    return $index ||= { map { $_->{name} => $_ } @{ $self->data } };
}

1;
