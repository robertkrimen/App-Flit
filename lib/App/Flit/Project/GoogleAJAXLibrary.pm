package App::Flit::Project::GoogleAJAXLibrary;

use Any::Moose;

extends qw/ App::Flit::Project /;

has scheme => qw/ is ro required 1 isa ArrayRef /;

sub load {
    my $self = shift;
    my %project = @_;

    my $name = $project{name};

    my ( @scheme );

    if      ( $name eq 'jquery-ui' )        { @scheme = ( qw/ jqueryui jquery-ui .min / ) }
    elsif   ( $name eq 'jquery' )           { @scheme = ( $name, $name, qw/.min / ) }
    elsif   ( $name eq 'prototype' )        { @scheme = ( $name, $name ) }
    elsif   ( $name eq 'scriptaculous' )    { @scheme = ( $name, $name ) }
    elsif   ( $name eq 'mootools' )         { @scheme = ( $name, $name, qw/ -yui-compressed / ) }
    else                                    { die "Invalid project ($name)" }
    
    return $self->new( %project, scheme => \@scheme );
}

sub location {
    my $self = shift;
    my %given = @_;

    my @scheme = @{ $self->scheme };

    my $version = $given{version};
    $version = $self->source->{default_version} unless $version;
    die "Missing version" unless defined $version;

    my $location = "http://ajax.googleapis.com/ajax/libs/$scheme[0]/$version/$scheme[1]";
    $location .= $scheme[2] if $given{compressed} && $scheme[2];
    $location .= '.js';

    return $location;
}

1;
