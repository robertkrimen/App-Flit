#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

plan qw/no_plan/;

use App::Flit::Finder;

sub lookup ($$;$@) {
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my ( $target, $project, $version ) = ( shift, shift, shift );
    my $found = App::Flit::Finder->lookup( $target );
    ok( $found ) or return;
    is( $project, $found->{project} );
    is( $version, $found->{version} ) if defined $version;
    if ( @_ ) {
        cmp_deeply( $found, superhashof( { @_ } ) );
    }
}

lookup 'jquery', 'jquery';
lookup 'jquery-x2s', 'jquery-x2s';
lookup 'jquerymin', 'jquery', undef, compressed => 1;
lookup 'jquery1', 'jquery', '1';
lookup 'jquery1min', 'jquery', '1', compressed => 1;
lookup 'jquery1.2min', 'jquery', '1.2', compressed => 1;
lookup 'jquery-1.2min', 'jquery', '1.2', compressed => 1;
lookup 'jquery-1.2.1min', 'jquery', '1.2.1', compressed => 1;
lookup 'jquery-1.2.1-min', 'jquery', '1.2.1', compressed => 1;

__END__

exit;



__END__

sub t2u ($) {
    return App::Flit->target2uri( @_ );
}

is( t2u "jquery", "http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" );
is( t2u "jquerymin", "http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js" );
is( t2u "jquery-min", "http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js" );
is( t2u "jquery1", "http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" );
is( t2u "jquery1min", "http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js" );
is( t2u "jquery1.2min", "http://ajax.googleapis.com/ajax/libs/jquery/1.2/jquery.min.js" );
is( t2u "jquery-1.2min", "http://ajax.googleapis.com/ajax/libs/jquery/1.2/jquery.min.js" );
is( t2u "jquery-1.2.1min", "http://ajax.googleapis.com/ajax/libs/jquery/1.2.1/jquery.min.js" );
is( t2u "jquery-1.2.1-min", "http://ajax.googleapis.com/ajax/libs/jquery/1.2.1/jquery.min.js" );

