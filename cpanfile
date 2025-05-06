use strict;      # satisfy linter
use warnings;    # satisfy linter

=pod

Semantic sugar to simplify management of modules which changed their required Perl version
(directly or via dependencies)

    requires_by_perl Module,
        prior     5.010 => 'use version X',
        prior     5.012 => 'use version Y',
        otherwise do_not_install
        ;

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
sub do_not_install { undef }

# Last versions which install on < 5.12
if ( "$]" < 5.012 ) {
    requires 'Data::Section', '==0.200007';
    requires 'Data::OptList', '==0.113';
    requires 'Plack', '==1.0050';
    requires 'Software::License::Perl_5', '==0.104004';
    requires 'Sub::Exporter', '==0.990';
    requires 'Test::Deep',    '==1.130';
}
else {
    requires 'Software::License::Perl_5';
    requires 'Plack::Test';
}

if ( "$]" >= 5.010 ) {
    requires 'Pod::Man',     '>= 5.00';
    requires 'Perl::Critic', '>= 1.144';
}
else {
    requires 'Pod::Man',     '==4.14';
    requires 'Perl::Critic', '==1.142';
}

requires 'App::cpanoutdated';
requires 'ExtUtils::MakeMaker';
requires 'File::Temp';
requires 'List::MoreUtils';
requires 'Module::Build';
requires 'Perl::Tidy', '>= 20220217';
requires 'Pod::Readme' if "$]" >= 5.012000;
requires 'Pod::Spell', '>= 1.25';
requires 'Test2::Bundle::Extended';
requires 'Test2::Plugin::NoWarnings';
requires 'Test2::Suite';
requires 'Test2::Tools::Explain';
requires 'Test::Builder';
requires 'Test::CPAN::Meta';
requires 'Test::Differences';
requires 'Test::EOL';
requires 'Test::Fatal';
requires 'Test::MinimumVersion';
requires 'Test::MockModule';
requires 'Test::Mojibake';
requires 'Test::More';
requires 'Test::Needs';
requires 'Test::NoTabs';
requires 'Test::Perl::Critic';
requires 'Test::Pod';
requires 'Test::Pod::Coverage';
requires 'Test::Portability::Files';
requires 'Test::RequiresInternet';
requires 'Test::Simple';
requires 'Test::Spelling';
requires 'Test::Synopsis';
requires 'Test::Version';
requires 'Test::Warnings';

if ( "$]" >= 5.010 ) {
    requires 'Devel::Cover';
    requires 'Devel::Cover::Report::Codecov';
    requires 'Devel::Cover::Report::Coveralls';
    requires 'Minilla';
    requires 'Test2::Harness';
    requires 'Test::Vars';
}

if ( "$]" >= 5.010001 ) {
    requires 'Test2::Harness::Renderer::JUnit';
}

if ( "$]" >= 5.012 ) {
    requires 'Code::TidyAll::Plugin::SortLines::Naturally';
    requires 'Code::TidyAll::Plugin::Test::Vars';
    requires 'Code::TidyAll::Plugin::UniqueLines';
    requires 'Pod::Coverage::TrustPod';
}

if ( "$]" < 5.014 ) {
    requires 'IO::Socket::IP', '==0.41';
}

if ( "$]" >= 5.020 ) {
    requires 'Dist::Zilla::PluginBundle::Author::ETHER';
    requires 'Dist::Zilla::PluginBundle::Author::OALDERS';
    requires 'Dist::Zilla::PluginBundle::DROLSKY';
    requires 'Dist::Zilla::PluginBundle::Milla';

	requires_by_perl 'Dist::Zilla::PluginBundle::RJBS',
		prior 5.020 => do_not_install,
		prior 5.026 => '==5.023',
		prior 5.034 => '==5.025',
        otherwise      '>5.028' # 5.028 requires v5.36 whereas following versions only v5.34, so omit it
		;

    requires 'Dist::Zilla::PluginBundle::Starter::Git';
    requires 'Dist::Zilla::Plugin::CheckChangeLog';
    requires 'Dist::Zilla::Plugin::CopyFilesFromRelease';
    requires 'Dist::Zilla::Plugin::Deprecated';
    requires 'Dist::Zilla::Plugin::Git::Contributors';
    requires 'Dist::Zilla::Plugin::GitHubREADME::Badge';
    requires 'Dist::Zilla::Plugin::OurPkgVersion';
    requires 'Dist::Zilla::Plugin::Regenerate::AfterReleasers';
    requires 'Dist::Zilla::Plugin::StaticInstall';
    requires 'Dist::Zilla::Plugin::Test::ReportPrereqs';

    # ...
}
