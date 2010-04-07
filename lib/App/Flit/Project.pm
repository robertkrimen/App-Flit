package App::Flit::Project;

use Any::Moose;

has name => qw/ is ro required 1 isa Str /;
has source => qw/ is ro required 1 isa HashRef /;

1;
