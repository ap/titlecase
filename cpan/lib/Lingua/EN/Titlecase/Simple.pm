use 5.008001; use strict; use warnings; use utf8;

package Lingua::EN::Titlecase::Simple;

our $VERSION = '1.005';

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

__END__

=pod

=encoding UTF-8

=head1 NAME

Lingua::EN::Titlecase::Simple - John Gruber's headline capitalization script

=head1 SYNOPSIS

 use Lingua::EN::Titlecase::Simple 'titlecase';

 print titlecase 'Small word at end is nothing to be afraid of';
 # output:        Small Word at End Is Nothing to Be Afraid Of

 print titlecase 'IF IT’S ALL CAPS, FIX IT';
 # output:        If It’s All Caps, Fix It

=head1 DESCRIPTION

This module capitalizes English text suitably for use as a headline, based on
traditional editorial rules from I<The New York Times Manual of Style>.

=head1 INTERFACE

There are no default exports.

=head2 C<titlecase>

Takes one or more strings as arguments, each representing one headline to capitalize.

When given a single string, returns a scalar.
When given several strings, returns a list in list context, but an arrayref in scalar context.
When given nothing, returns nothing in list context or undef in scalar context.

This function can be exported on request.

Note that the arrayref return is problematic because it depends on the number
of arguments. If you have a variable number of arguments to pass, and that
number can sometimes be less than 2, you will sometimes get a plain scalar or
an undefined value instead of the arrayref you expected. Passing multiple
strings in scalar context is therefore L<discouraged|perlpolicy/discouraged>.

=head2 C<@SMALL_WORD>

Contains the list of words to avoid capitalizing.

=head1 SEE ALSO

L<Lingua::EN::Titlecase> provides a much more heavyweight, modular solution
for the same problem. If you seriously disagree with the style rules in this
module somewhere, you may be happier with that one.

=cut
