#!/usr/bin/perl
use strict; use warnings;

use Test::More;
use if @ARGV != 0, 'IPC::Open2' => 'open2';
use if @ARGV == 0, 'Lingua::EN::Titlecase::Simple' => 'titlecase';
use Data::Dumper 'Dumper';
use constant TEXTMODE => ':encoding(UTF-8)';

sub pp { s/\A\$VAR1 = //, s/;\s*\z//, return $_ for Dumper $_[0]; }

defined &titlecase or *titlecase = sub {
	open2( my $cout, my $cin, @ARGV ) or die "Couldn't execute @ARGV\: $!\n";
	binmode $_, TEXTMODE for $cin, $cout;

	print { $cin } join "\n", @_;
	close $cin or die $!;

	chomp( my @result = readline $cout );
	close $cout or die $!;

	@result;
};

binmode DATA, TEXTMODE;

my @testcase =
	map [ split /\n/ ],
	do { local $/ = ""; <DATA> }; # $/ = "" is paragraph mode

plan tests => 0+@testcase;

my @result = titlecase( map $_->[0], @testcase );

for ( @testcase ) {
	my ( $input, $expect ) = @$_;
	is shift @result, $expect, pp $input;
}

__END__

For step-by-step directions email someone@gmail.com
For Step-by-Step Directions Email someone@gmail.com

2lmc Spool: 'Gruber on OmniFocus and Vapo(u)rware'
2lmc Spool: 'Gruber on OmniFocus and Vapo(u)rware'

Have you read “The Lottery”?
Have You Read “The Lottery”?

your hair[cut] looks (nice)
Your Hair[cut] Looks (Nice)

People probably won't put http://foo.com/bar/ in titles
People Probably Won't Put http://foo.com/bar/ in Titles

Scott Moritz and TheStreet.com’s million iPhone la‑la land
Scott Moritz and TheStreet.com’s Million iPhone La‑La Land

BlackBerry vs. iPhone
BlackBerry vs. iPhone

Notes and observations regarding Apple’s announcements from ‘The Beat Goes On’ special event
Notes and Observations Regarding Apple’s Announcements From ‘The Beat Goes On’ Special Event

Read markdown_rules.txt to find out how _underscores around words_ will be interpretted
Read markdown_rules.txt to Find Out How _Underscores Around Words_ Will Be Interpretted

Q&A with Steve Jobs: 'That's what happens in technology'
Q&A With Steve Jobs: 'That's What Happens in Technology'

What is AT&T's problem?
What Is AT&T's Problem?

Apple deal with AT&T falls through
Apple Deal With AT&T Falls Through

this v that
This v That

this vs that
This vs That

this v. that
This v. That

this vs. that
This vs. That

The SEC's Apple probe: what you need to know
The SEC's Apple Probe: What You Need to Know

'by the way, small word at the start but within quotes.'
'By the Way, Small Word at the Start but Within Quotes.'

Small word at end is nothing to be afraid of
Small Word at End Is Nothing to Be Afraid Of

Starting sub-phrase with a small word: a trick, perhaps?
Starting Sub-Phrase With a Small Word: A Trick, Perhaps?

Sub-phrase with a small word in quotes: 'a trick, perhaps?'
Sub-Phrase With a Small Word in Quotes: 'A Trick, Perhaps?'

Sub-phrase with a small word in quotes: "a trick, perhaps?"
Sub-Phrase With a Small Word in Quotes: "A Trick, Perhaps?"

"Nothing to Be Afraid of?"
"Nothing to Be Afraid Of?"

a thing
A Thing

Dr. Strangelove (or: how I Learned to Stop Worrying and Love the Bomb)
Dr. Strangelove (Or: How I Learned to Stop Worrying and Love the Bomb)

  this is trimming
This Is Trimming

this is trimming  
This Is Trimming

  this is trimming  
This Is Trimming

IF IT’S ALL CAPS, FIX IT
If It’s All Caps, Fix It

___if emphasized, keep that way___
___If Emphasized, Keep That Way___

What could/should be done about slashes?
What Could/Should Be Done About Slashes?

Never touch paths like /var/run before/after /boot
Never Touch Paths Like /var/run Before/After /boot

There are 100's of buyer's guides
There Are 100's of Buyer's Guides

To-do: in-house en-Route BY-pass
To-Do: In-House En-Route By-Pass
