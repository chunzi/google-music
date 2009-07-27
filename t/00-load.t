#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Google::Music' );
}

diag( "Testing Google::Music $Google::Music::VERSION, Perl $], $^X" );
