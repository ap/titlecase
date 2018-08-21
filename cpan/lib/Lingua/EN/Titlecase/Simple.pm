use 5.008001; use strict; use warnings; use utf8;

package Lingua::EN::Titlecase::Simple;

our $VERSION = '1.003';

BEGIN { # FIXUP: this stuff is here to allow `prove` to Just Work during development
	my $fn = '../titlecase';
	open my $fh, '<', $fn or die "Couldn't read $fn: $!\n";
	local $/;
	( my $src = "#line 1 $fn\n" . readline $fh ) =~ s!\nuse open .*!1!s or die "Source fixup failed";
	open $fh, '<', \$src;
	my @saved_inc = @INC;
	@INC = sub { @INC = @saved_inc; $fh };
	require 'titlecase';
} # END FIXUP

sub import {
	my ( $class, $pkg, $file, $line ) = ( shift, caller );
	die "Unknown symbol: $_ at $file line $line.\n" for grep 'titlecase' ne $_, @_;
	no strict 'refs';
	*{ $pkg . '::titlecase' } = \&titlecase if @_;
}

1;
