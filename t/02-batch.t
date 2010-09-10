#!perl -T

use Test::More tests => 3;
use Lingua::EN::Titlecase::Simple qw/titlecase/;
use open qw/:encoding(UTF-8)/;
use utf8;

my @conv = titlecase("FIX THIS", "Fix that now", "Finally, fix that please");

is_deeply(\@conv, ['Fix This', 'Fix That Now', 'Finally, Fix That Please'], 'Wanted array for batch operation, received array');

my $conv = titlecase('Save room for Cheese-cake', 'Who put the bump in the bump-shoo-bump-shoo-bump?');

is_deeply($conv, ['Save Room for Cheese-Cake', 'Who Put the Bump in the Bump-Shoo-Bump-Shoo-Bump?'], 'Wanted array-ref for batch operation, received array-ref');

@conv = titlecase('Hey hey, my my');

is_deeply(\@conv, ['Hey Hey, My My'], 'Wanted array for just one text, received array');

done_testing();
