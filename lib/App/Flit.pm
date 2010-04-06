package App::Flit;
# ABSTRACT: -

use warnings;
use strict;

sub parse_digitdot_version {
    local $_ = shift;

    s/\b([\d\.\- ]+)\d//; my $version = $1;
    $version = 1 unless defined $version && length $version;
    s/^\s*//, s/\s*$// for $version;
    $version =~ s/[\.\- ]+/\./g; # Normalize version

    return ( $_, $version );
}

sub check_version {
    my $version = shift;
    my @check = @_;

    if ( 0 ) {}
    elsif ( defined $check[0] && $version eq $check[0] ) {}
    elsif ( defined $check[1] && $version =~ $check[1] ) {}
    elsif ( defined $check[2] && grep { $version eq $_ } @{ $check[2] } ) {}
    else {
        return undef;
    }

    return 1;
}

sub target2uri {
    my $self = shift;
    my $target = shift;

    local $_ = $target;

    my $uri;
    if ( s/^\s*jquery-*ui[-\s]*// ) {

        my $min = s/(?<=\d)?min\b//i;

        my $version;
        ( $_, $version ) = parse_digitdot_version $_;

        die "Do not know how to flit jquery target ($target)" if m/[^- ]+/;

        if ( $version eq '1' ) {}
        elsif ( $version =~ m/^1\.[567]$/ ) {}
        elsif ( grep { $version eq $_ } qw/ 1.5.2 1.5.3 1.6 1.7.0 1.7.1 1.7.2 / ) {}
        else {
            die "Do not know hot to flit jquery ui target ($target) for version ($version)";
        }

        $uri = "http://ajax.googleapis.com/ajax/libs/jqueryui/$version/jquery-ui";
        $uri .= ".min" if $min;
        $uri .= ".js";
    }
    elsif ( s/^\s*jquery[-\s]*// ) {

        # TODO jquerymin ?

        my $min = s/(?<=\d)?min\b//i;

        my $version;
        ( $_, $version ) = parse_digitdot_version $_;

#        die "Do not know how to flit jquery target ($target)" if m/[^- ]+/;
        goto OTHERWISE if m/[^- ]+/;

        $uri = "http://ajax.googleapis.com/ajax/libs/jquery/$version/jquery";
        $uri .= ".min" if $min;
        $uri .= ".js";
    }
    elsif ( s/^\s*prototype[-\s]*// ) {

        my $version;
        ( $_, $version ) = parse_digitdot_version $_;

        if ( $version eq '1' ) {}
        elsif ( $version =~ m/^1\.[6](?:\.[01])?$/ ) {}
        elsif ( grep { $version eq $_ } qw/ 1.6.0.2 1.6.0.3 1.6.1.0 / ) {}
        else {
            die "Do not know hot to flit prototype target ($target) for version ($version)";
        }

        $uri = "http://ajax.googleapis.com/ajax/libs/prototype/$version/prototype.js";
    }
    elsif ( s/^\s*script\.?aculo\,?us[-\s]*// ) {

        my $version;
        ( $_, $version ) = parse_digitdot_version $_;

        if ( $version eq '1' ) {}
        elsif ( $version =~ m/^1\.[8]$/ ) {}
        elsif ( grep { $version eq $_ } qw/ 1.8.1 1.8.2 1.8.3 / ) {}
        else {
            die "Do not know hot to flit prototype target ($target) for version ($version)";
        }

        $uri = "http://ajax.googleapis.com/ajax/libs/scriptaculous/$version/scriptaculous.js";
    }
    elsif ( s/^\s*mootools\s*// ) {

        my $min = s/(?<=\d)?min\b//i;
        $min ||= s/(?<=\d)?yui-compressed\b//i;

        my $version;
        ( $_, $version ) = parse_digitdot_version $_;

        if ( $version eq '1' ) {}
        elsif ( $version =~ m/^1\.[12]$/ ) {}
        elsif ( grep { $version eq $_ } qw/ 1.1.1 1.1.2 1.2.1 1.2.2 1.2.3 1.2.4 / ) {}
        else {
            die "Do not know hot to flit mootools target ($target) for version ($version)";
        }

        $uri = "http://ajax.googleapis.com/ajax/libs/mootools/$version/mootools";
        $uri .= "-yui-compressed" if $min;
        $uri .= ".js";
    }
    else {
OTHERWISE:
        local $_ = $target;

        my $version;
        ( $_, $version ) = parse_digitdot_version $_;
        
        my $name = $_;
        my @found = grep { $_->{name} eq $name } $self->find( $_ );

        die "Nothing found for target ($_)" unless @found;

        if ( @found == 1 ) {
            $uri = $found[0]->{releases}->[0]->{download};
        }
        else {
            die "Be more specific.\n";
        }
    }

    die "Do not know how to flit target ($target)" unless $uri;

    return $uri;

}

sub find {
    my $self = shift;
    my $query = shift;

    die "Missing query" unless defined $query;

    $query = qr/$query/ unless ref $query eq 'Regexp';

#    require App::Flit::Source::builtin;
    require App::Flit::Source::jquery;

    my @data;
#    push @data, @{ App::Flit::Source::bultin->data };
    push @data, @{ App::Flit::Source::jquery->data };

    return grep { $_->{name} =~ $query } @data;
}

1;
