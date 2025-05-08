use strict;      # satisfy linter
use warnings;    # satisfy linter

=pod

=head1 requires_by_perl

Semantic helper to simplify management of modules which have changed
their required Perl version (directly or via dependencies)

    requires_by_perl 'Module',
        prior     5.010 => 'use version X',
        prior     5.012 => 'use version Y',
        otherwise skip
        ;

=head1 prior

    prior VERSION => VERSION_SPEC, ...

    requires_by_perl 'Module',
        prior 5.010 => skip,
        ;

Semantic helper function to give data meaning,
which version of a module should be installed for a Perl version
prior to specified version.

=head1 otherwise

    otherwise VERSION_SPEC

    requires_by_perl 'Module',
        prior 5.010 => skip,
        otherwise '5.0',
        ;

Semantic sugar function to give data meaning,
which version of a module to install when none of the previous
L</prior> expressions match.

=head1 skip

    prior 5.010 => skip,
    otherwise skip,

Semantic helper function representing L<VERSION_SPEC> with the meaning:
do not install explicitly.

=cut

sub requires_by_perl {
	my @requires = (shift);

	while (@_) {
		shift, next
			unless @_ == 1 || $] < shift
			;

		push @requires, shift // return;
		last;
	}

	requires @requires;
}

sub prior { @_ }
sub otherwise { @_ }
sub skip { undef }

requires_by_perl 'App::cpanoutdated',
	;

requires_by_perl 'Code::TidyAll::Plugin::SortLines::Naturally',
	prior 5.012 => skip
	;

requires_by_perl 'Code::TidyAll::Plugin::Test::Vars',
	prior 5.012 => skip,
	;

requires_by_perl 'Code::TidyAll::Plugin::UniqueLines',
	prior 5.014 => skip,
	;

requires_by_perl 'Data::OptList',
	prior 5.012 => '==0.113',
	otherwise skip
	;

requires_by_perl 'Data::Section',
	prior 5.012 => '==0.200007',
	otherwise skip,
	;

requires_by_perl 'Devel::Cover',
	prior 5.010 => skip,
	prior 5.012 => '==1.42',
	;

requires_by_perl 'Devel::Cover::Report::Codecov',
	prior 5.010 => skip,
	;

requires_by_perl 'Devel::Cover::Report::Coveralls',
	prior 5.010 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::CheckChangeLog',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::CopyFilesFromRelease',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::Deprecated',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::Git::Contributors',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::GitHubREADME::Badge',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::OurPkgVersion',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::Regenerate::AfterReleasers',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::StaticInstall',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::Plugin::Test::ReportPrereqs',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::PluginBundle::Author::ETHER',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::PluginBundle::Author::OALDERS',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::PluginBundle::DROLSKY',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::PluginBundle::Milla',
	prior 5.020 => skip,
	;

requires_by_perl 'Dist::Zilla::PluginBundle::RJBS',
	prior 5.020 => skip,
	prior 5.026 => '==5.023',
	prior 5.034 => '==5.025',
	otherwise	   '>5.028' # 5.028 requires v5.36 whereas following versions only v5.34, so omit it
	;

requires_by_perl 'Dist::Zilla::PluginBundle::Starter::Git',
	prior 5.020 => skip,
	;

requires_by_perl 'ExtUtils::MakeMaker',
	;

requires_by_perl 'File::Temp',
	;

requires_by_perl 'IO::Socket::IP',
	prior 5.014 => '==0.41',
	;

requires_by_perl 'List::MoreUtils',
	;

requires_by_perl 'Minilla',
	prior 5.010 => skip,
	;

requires_by_perl 'Module::Build',
	;

requires_by_perl 'Perl::Critic',
	prior 5.010 => '==1.142',
    otherwise      '>= 1.144',
	;

requires_by_perl 'Perl::Tidy', '>= 20220217',
	;

requires_by_perl 'Plack',
	prior 5.012 => '==1.0050',
	otherwise skip
	;

requires_by_perl 'Plack::Test',
	prior 5.012 => skip
	;

requires_by_perl 'Pod::Coverage::TrustPod',
	prior 5.014 => skip,
	;

requires_by_perl 'Pod::Man',
	prior 5.010 => '==4.14',
	prior 5.012 => '==5.01',
	;

requires_by_perl 'Pod::Readme',
	prior 5.012 => skip,
	;

requires_by_perl 'Pod::Spell', '>= 1.25',
	;


requires_by_perl 'Software::License::Perl_5',
	prior 5.012 => '==0.104004',
	;

requires_by_perl 'Sub::Exporter',
	prior 5.012 => '==0.990',
	otherwise skip
	;

requires_by_perl 'Test2::Bundle::Extended',
	;

requires_by_perl 'Test2::Harness',
	prior 5.010 => skip,
	prior 5.014 => '==1.000156',
	;

requires_by_perl 'Test2::Harness::Renderer::JUnit',
	prior 5.010001 => skip,
	prior 5.014	   => '==1.000005',
	;

requires_by_perl 'Test2::Plugin::NoWarnings',
	;

requires_by_perl 'Test2::Suite',
	;

requires_by_perl 'Test2::Tools::Explain',
	;

requires_by_perl 'Test::Builder',
	;

requires_by_perl 'Test::CPAN::Meta',
	;

requires_by_perl 'Test::Deep',
	prior 5.012 => '==1.130',
	otherwise skip
	;

requires_by_perl 'Test::Differences',
	;

requires_by_perl 'Test::EOL',
	;

requires_by_perl 'Test::Fatal',
	;

requires_by_perl 'Test::MinimumVersion',
	;

requires_by_perl 'Test::MockModule',
	prior 5.012 => '==0.178',
	;

requires_by_perl 'Test::Mojibake',
	;

requires_by_perl 'Test::More',
	;

requires_by_perl 'Test::Needs',
	;

requires_by_perl 'Test::NoTabs',
	;

requires_by_perl 'Test::Perl::Critic',
	;

requires_by_perl 'Test::Pod',
	;

requires_by_perl 'Test::Pod::Coverage',
	;

requires_by_perl 'Test::Portability::Files',
	;

requires_by_perl 'Test::RequiresInternet',
	;

requires_by_perl 'Test::Simple',
	;

requires_by_perl 'Test::Spelling',
	;

requires_by_perl 'Test::Synopsis',
	;

requires_by_perl 'Test::Vars',
	prior 5.010 => skip,
	;

requires_by_perl 'Test::Version',
	;

requires_by_perl 'Test::Warnings',
	;

