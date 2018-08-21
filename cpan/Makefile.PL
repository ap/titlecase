use 5.008001; use strict; use warnings;

my $u = 'github.com/ap/titlecase';

my %META = (
	name        => 'Lingua-EN-Titlecase-Simple',
	author      => [
		'John Gruber <http://daringfireball.net/2008/05/title_case>',
		'Aristotle Pagaltzis <pagaltzis@gmx.de>',
	],
	license     => 'mit',
	x_copyright => { holder => 'John Gruber, Aristotle Pagaltzis', year => 2018 },
	no_index    => {},
	prereqs     => {
		configure => { requires => {qw(
			ExtUtils::MakeMaker 0
		)} },
		runtime => { requires => {qw(
			perl                5.008001
			strict              0
			utf8                0
			warnings            0
		)} },
		test => { requires => {qw(
			Data::Dumper        0
			Test::More          0
			constant            0
			if                  0
			open                0
		)} },
	},
	dynamic_config => 0,
	resources      => {
		repository => { type => 'git', url => "git://$u.git", web => "https://$u" },
		bugtracker => { web => "https://$u/issues" },
	},
);

my %MM_ARGS = ( EXE_FILES => [ 'bin/titlecase' ] );

sub MY::postamble { <<'' }
create_distdir : MANIFEST
MANIFEST :
	( git ls-files ':!README.pod' . ; echo MANIFEST ) > MANIFEST
distdir : boilerplate
.PHONY  : boilerplate
boilerplate : distmeta
	$(PERL) boilerplate.pl $(DISTVNAME)

## BOILERPLATE ###############################################################
require ExtUtils::MakeMaker;

# have to do this since old EUMM dev releases miss the eval $VERSION line
my $eumm_version  = eval $ExtUtils::MakeMaker::VERSION;
my $mymeta        = $eumm_version >= 6.57_02;
my $mymeta_broken = $mymeta && $eumm_version < 6.57_07;

($MM_ARGS{NAME} = $META{name}) =~ s/-/::/g;
($MM_ARGS{VERSION_FROM} = "lib/$MM_ARGS{NAME}.pm") =~ s{::}{/}g;
$MM_ARGS{ABSTRACT_FROM} = $MM_ARGS{VERSION_FROM};
$META{license} = [ $META{license} ]
	if $META{license} && !ref $META{license};
$MM_ARGS{LICENSE} = $META{license}[0]
	if $META{license} && $eumm_version >= 6.30;
$MM_ARGS{NO_MYMETA} = 1
	if $mymeta_broken;
$MM_ARGS{META_ADD} = { 'meta-spec' => { version => 2 }, %META }
	unless -f 'META.yml';
$MM_ARGS{PL_FILES} ||= {};
$MM_ARGS{NORECURS} = 1
	if not exists $MM_ARGS{NORECURS};

for (qw(configure build test runtime)) {
	my $key = $_ eq 'runtime' ? 'PREREQ_PM' : uc $_.'_REQUIRES';
	my $r = $MM_ARGS{$key} = {
		%{$META{prereqs}{$_}{requires} || {}},
		%{delete $MM_ARGS{$key} || {}},
	};
	defined $r->{$_} or delete $r->{$_} for keys %$r;
}

$MM_ARGS{MIN_PERL_VERSION} = delete $MM_ARGS{PREREQ_PM}{perl} || 0;

delete $MM_ARGS{MIN_PERL_VERSION}
	if $eumm_version < 6.47_01;
$MM_ARGS{BUILD_REQUIRES} = {%{$MM_ARGS{BUILD_REQUIRES}}, %{delete $MM_ARGS{TEST_REQUIRES}}}
	if $eumm_version < 6.63_03;
$MM_ARGS{PREREQ_PM} = {%{$MM_ARGS{PREREQ_PM}}, %{delete $MM_ARGS{BUILD_REQUIRES}}}
	if $eumm_version < 6.55_01;
delete $MM_ARGS{CONFIGURE_REQUIRES}
	if $eumm_version < 6.51_03;

ExtUtils::MakeMaker::WriteMakefile(%MM_ARGS);
## END BOILERPLATE ###########################################################
