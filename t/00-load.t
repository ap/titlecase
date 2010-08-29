#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Lingua::EN::TitleCaps' ) || print "Bail out!
";
}

diag( "Testing Lingua::EN::TitleCaps $Lingua::EN::TitleCaps::VERSION, Perl $], $^X" );
