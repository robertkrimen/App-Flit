#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

plan qw/no_plan/;

use App::Flit;

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

