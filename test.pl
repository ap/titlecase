#!/usr/bin/perl
# Copyright (c) 2008, Aristotle Pagaltzis {{{
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# }}}

use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );

use Test::More;
use IPC::Open2;

use constant INPUT  => 0;
use constant OUTPUT => 1;

@ARGV or die "usage: $0 someprogram [programoptions ...]\n\n";

my @testcase =
	map [ split /\n/ ],
	do { local $/ = ""; <DATA> }; # $/ = "" is paragraph mode

plan tests => 0 + @testcase;

open2( my $cout, my $cin, @ARGV )
	or die "Couldn't execute @ARGV\: $!\n";

for ( @testcase ) {
	print { $cin } $_->[ INPUT ], "\n";
}

close $cin;

chomp( my @result = <$cout> );

close $cout;

for my $i ( 0 .. $#result ) {
	is( $result[ $i ], $testcase[ $i ][ OUTPUT ] );
}

# vim: ts=4 sts=4 sw=4 sr fdm=marker
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

What could/should be done about slashes?
What Could/Should Be Done About Slashes?

Never touch paths like /var/run before/after /boot
Never Touch Paths Like /var/run Before/After /boot
