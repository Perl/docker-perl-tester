use strict;      # satisfy linter
use warnings;    # satisfy linter

requires 'App::cpanoutdated';
requires 'ExtUtils::MakeMaker';
requires 'File::Temp';
requires 'List::MoreUtils';
requires 'Module::Build';
requires 'Perl::Critic';
requires 'Perl::Tidy', '>= 20220217';
requires 'Plack::Test';
requires 'Pod::Readme' if "$]" >= 5.012000;
requires 'Pod::Spell', '>= 1.25';
requires 'Software::License::Perl_5';
requires 'Test2::Bundle::Extended';
requires 'Test2::Plugin::NoWarnings';
requires 'Test2::Suite';
requires 'Test2::Tools::Explain';
requires 'Test::Builder';
requires 'Test::CPAN::Meta';
requires 'Test::Deep';
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
    requires 'Test::Vars';
}

if ( "$]" >= 5.012 ) {
    requires 'Code::TidyAll::Plugin::SortLines::Naturally';
    requires 'Code::TidyAll::Plugin::Test::Vars';
    requires 'Code::TidyAll::Plugin::UniqueLines';
    requires 'Pod::Coverage::TrustPod';
}

if ( "$]" >= 5.020 ) {
    requires 'Dist::Zilla::PluginBundle::Author::ETHER';
    requires 'Dist::Zilla::PluginBundle::Author::OALDERS';
    requires 'Dist::Zilla::PluginBundle::DROLSKY';
    requires 'Dist::Zilla::PluginBundle::Milla';
    requires 'Dist::Zilla::PluginBundle::RJBS';
    requires 'Dist::Zilla::Plugin::CopyFilesFromRelease';
    requires 'Dist::Zilla::Plugin::Git::Contributors';
    requires 'Dist::Zilla::Plugin::OurPkgVersion';
    requires 'Dist::Zilla::Plugin::StaticInstall';
    requires 'Dist::Zilla::Plugin::Test::ReportPrereqs';

    # ...
}
