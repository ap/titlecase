use strict; use warnings;

use Test::More;

my @module = qw(
	Lingua::EN::Titlecase::Simple;
);

plan tests => 0+@module;

diag "Testing on Perl $] at $^X";

for my $module ( @module ) {
	use_ok( $module ) or BAIL_OUT "Cannot load module '$module'";
	no warnings 'uninitialized';
	diag "Testing $module @ " . $module->VERSION;
}
