use strict; use warnings; use utf8;

package Lingua::EN::Titlecase::Simple;

# ABSTRACT: John Gruber's headline capitalization script

use Exporter::Tidy all => [ 'titlecase' ];

my @small_words = qw( (?<!q&)a an and as at(?!&t) but by en for if in of on or the to v[.]? via vs[.]? );
my $small_re = join '|', @small_words;

my $apos = qr/ (?: ['’] [[:lower:]]* )? /x;

sub titlecase {
	my @titles = @_;

	return unless scalar @titles;

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

1;
