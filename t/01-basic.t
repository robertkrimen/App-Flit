#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

plan qw/no_plan/;

use App::Flit;

sub target2uri ($) {
    return App::Flit->target2uri( @_ );
}

is( target2uri "jquery", "http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js" );
