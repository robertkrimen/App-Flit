package App::Flit;

use warnings;
use strict;

=head1 NAME

App::Flit -

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

sub parse_digitdot_version {
    local $_ = shift;

    s/\b([\d\.\- ]+)\b//; my $version = $1;
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

        die "Do not know how to flit jquery target ($target)" if m/[^- ]+/;

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
        die "Do not know how to flit target ($target)";
    }

    return $uri;

}
=head1 AUTHOR

Robert Krimen, C<< <rkrimen at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-flit at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-Flit>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::Flit


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-Flit>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-Flit>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-Flit>

=item * Search CPAN

L<http://search.cpan.org/dist/App-Flit/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010 Robert Krimen.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of App::Flit
