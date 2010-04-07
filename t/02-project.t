#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

plan qw/no_plan/;

use App::Flit::Index;
my $index = App::Flit::Index->new();

my( $project );

$project = $index->project( 'jquery-ui' );
ok( $project );
is( $project->name, 'jquery-ui' );
is( $project->location, 'http://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.js' );

