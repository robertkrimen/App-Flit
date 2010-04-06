package App::Flit::Source::jquery;

use strict;
use warnings;

use App::Flit::Source::jquery::Data;

sub data {
    return App::Flit::Source::jquery::Data->data;
}

my $index;
sub index {
    my $self = shift;
    return $index ||= { map { $_->{name} => $_ } @{ $self->data } };
}

1;
