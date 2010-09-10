package Lingua::EN::Titlecase::Simple;

BEGIN {
	use Exporter 'import';
	@EXPORT_OK = qw/titlecase/;
}

use warnings;
use strict;
use utf8;

# ABSTRACT: Automatically title-case headlines and title-texts.

=head1 NAME

Lingua::EN::Titlecase::Simple - Automatically title-case headlines and title-texts.

=head1 SYNOPSIS

	use Lingua::EN::Titlecase::Simple qw/titlecase/;

	print titlecase('Small word at end is nothing to be afraid of');
		# prints 'Small Word at End Is Nothing to Be Afraid Of'
	
	print titlecase('IF IT’S ALL CAPS, FIX IT');
		# prints 'If It’s All Caps, Fix It'

	# you can also batch-convert
	my @converted = titlecase("FIX THIS", "Fix that now", "don't forget This");

=head1 DESCRIPTION

This module provides a simple method for automatically titlecasing texts
(generally headings and title texts) according to traditional editorial
rules (it uses guidelines from "The New York Times Manual of Style").

While L<Lingua::EN::Titlecase> already provides this functionality,
this implementation is much lighter weight and provides a much simpler API.
You are encouraged to check Lingua::EN::Titlecase out and see which one
is better for your needs.

It should be noted that this module expects your input to be UTF-8, and
you can rest assured your special UTF-8 characters will remain intact.

This module is a CPANization of Aristotle Pagaltzis's fork of John
Gruber's Title Case script (see L<AUTHORS> for links to original source
code).

=head1 FUNCTIONS

=head2 titlecase( $text | @texts )

Returns a properly title-cased version of the provided text(s).

=cut

sub titlecase {
	my @titles = @_;

	return unless scalar @titles;

	my @small_words = qw( (?<!q&)a an and as at(?!&t) but by en for if in of on or the to v[.]? via vs[.]? );
	my $small_re = join '|', @small_words;

	my $apos = qr/ (?: ['’] [[:lower:]]* )? /x;

	my @conversions;

	foreach (@titles) {
		s{\A\s+}{}, s{\s+\z}{};

		$_ = lc $_ unless /[[:lower:]]/;

		s{
		\b (_*) (?:
		( [-_[:alpha:]]+ [@.:/] [-_[:alpha:]@.:/]+ $apos ) # URL, domain, or email
		|
		( (?i: $small_re ) $apos ) # or small word (case-insensitive)
		|
		( [[:alpha:]] [[:lower:]'’()\[\]{}]* $apos ) # or word w/o internal caps
		|
		( [[:alpha:]] [[:alpha:]'’()\[\]{}]* $apos ) # or some other word
		) (_*) \b
		}{
		$1 . (
		defined $2 ? $2 # preserve URL, domain, or email
		: defined $3 ? "\L$3" # lowercase small word
		: defined $4 ? "\u\L$4" # capitalize word w/o internal caps
		: $5 # preserve other kinds of word
		) . $6
		}exgo;

		# exceptions for small words: capitalize at start and end of title
		s{
		( \A [[:punct:]]* # start of title...
		| [:.;?!][ ]+ # or of subsentence...
		| [ ]['"“‘(\[][ ]* ) # or of inserted subphrase...
		( $small_re ) \b # ... followed by small word
		}{$1\u\L$2}xigo;

		s{
		\b ( $small_re ) # small word...
		(?= [[:punct:]]* \Z # ... at the end of the title...
		| ['"’”)\]] [ ] ) # ... or of an inserted subphrase?
		}{\u\L$1}xigo;
		
		push(@conversions, $_);
	}

	if (scalar @conversions > 1) {
		return wantarray ? @conversions : \@conversions;
	} else {
		return wantarray ? @conversions : $conversions[0];
	}
}

=head1 AUTHORS

Aristotle Pagaltzis (L<http://plasmasturm.org/code/titlecase/>), based on
work by John Gruber (L<http://daringfireball.net/2008/05/title_case>).

Made into a CPAN distribution by Ido Perlmuter, C<< <ido at ido50.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-lingua-en-titlecase-simple at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Lingua-EN-Titlecase-Simple>. I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc Lingua::EN::Titlecase::Simple

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-EN-Titlecase-Simple>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Lingua-EN-Titlecase-Simple>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Lingua-EN-Titlecase-Simple>

=item * Search CPAN

L<http://search.cpan.org/dist/Lingua-EN-Titlecase-Simple/>

=back

=head1 LICENSE AND COPYRIGHT

	Copyright 2008-2010 John Gruber, Aristotle Pagaltzis, Ido Perlmuter.

	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=cut

1;
