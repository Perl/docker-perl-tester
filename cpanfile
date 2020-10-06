use strict;      # satisfy linter
use warnings;    # satisfy linter

requires 'App::cpanoutdated';
requires 'Code::TidyAll::Plugin::SortLines::Naturally';
requires 'Code::TidyAll::Plugin::UniqueLines';
requires 'ExtUtils::MakeMaker';
requires 'File::Temp';
requires 'List::MoreUtils';
requires 'Module::Build';
requires 'Perl::Critic';
requires 'Perl::Tidy';
requires 'Plack::Test';
requires 'Pod::Coverage::TrustPod';
requires 'Pod::Readme' if "$]" >= 5.010001;
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
requires 'Test::Pod';
requires 'Test::Pod::Coverage';
requires 'Test::Portability::Files';
requires 'Test::RequiresInternet';
requires 'Test::Spelling';
requires 'Test::Simple';
requires 'Test::Synopsis';
requires 'Test::Vars' if "$]" >= 5.010;
requires 'Test::Version';
requires 'Test::Warnings';

if ( "$]" >= 5.010 ) {
    requires 'Code::TidyAll::Plugin::Test::Vars';
    requires 'Devel::Cover';
    requires 'Devel::Cover::Report::Codecov';
    requires 'Devel::Cover::Report::Coveralls';
    requires 'Minilla';
}

if ( "$]" >= 5.014 ) {
    requires 'Dist::Zilla::PluginBundle::Author::ETHER';
    requires 'Dist::Zilla::PluginBundle::Author::OALDERS';
    requires 'Dist::Zilla::PluginBundle::RJBS';
    requires 'Dist::Zilla::PluginBundle::Milla';
    requires 'Dist::Zilla::Plugin::OurPkgVersion';

    # ...
}
