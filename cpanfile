use strict;      # satisfy linter
use warnings;    # satisfy linter

requires 'Code::TidyAll::Plugin::SortLines::Naturally';
requires 'Code::TidyAll::Plugin::Test::Vars';
requires 'Code::TidyAll::Plugin::UniqueLines';
requires 'Devel::Cover';
requires 'Devel::Cover::Report::Codecov';
requires 'Devel::Cover::Report::Coveralls';
requires 'File::Temp';
requires 'List::MoreUtils';
requires 'Module::Build';
requires 'Pod::Coverage::TrustPod';
requires 'Pod::Readme';
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
requires 'Test::Pod';
requires 'Test::Pod::Coverage';
requires 'Test::Portability::Files';
requires 'Test::RequiresInternet';
requires 'Test::Spelling';
requires 'Test::Synopsis';
requires 'Test::Vars' if $] >= "5.10";
requires 'Test::Version';
requires 'Test::Warnings';