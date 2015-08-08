use strict; use warnings;

use Test::More 0.88; # for done_testing
use Lingua::EN::Titlecase::Simple qw/titlecase/;
use open qw/:encoding(UTF-8)/;
use utf8;

my @xyz = qw( X Y Z );

is_deeply       [ titlecase @xyz ], \@xyz, 'list   context, many args  => return list';
is_deeply scalar( titlecase @xyz ), \@xyz, 'scalar context, many args  => return arrayref';
is_deeply       [ titlecase 'X'  ], ['X'], 'list   context, single arg => return scalar';

done_testing;
