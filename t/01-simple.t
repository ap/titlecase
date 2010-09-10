#!perl -T

use Test::More;
use Lingua::EN::Titlecase::Simple qw/titlecase/;
use open qw/:encoding(UTF-8)/;
use utf8;

my @tests;

open(INPUT, "<:encoding(UTF-8)", "t/texts") or die "Can't open input: $!";
my $i = 0;
my $j = 0;
while (<INPUT>) {
	chomp;

	if ($_) {
		$tests[$i][$j++] = $_;
		
		if ($j > 1) {
			$j = 0;
			$i++;
		}
	}
}
close INPUT;

plan tests => scalar @tests;

foreach (@tests) {
	is(titlecase($_->[0]), $_->[1], 'ok');
}

done_testing();
