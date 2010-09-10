#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Lingua::EN::Titlecase::Simple' ) || print "Bail out!
";
}

diag( "Testing Lingua::EN::Titlecase::Simple $Lingua::EN::Titlecase::Simple::VERSION, Perl $], $^X" );
