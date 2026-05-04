#!/usr/bin/perl
use strict;
use warnings;

use ExtUtils::Installed;
use JSON::PP ();

my $installed = ExtUtils::Installed->new();

my @module_names = sort $installed->modules();
my @modules = map {
    my $module = $_;
    my $version = eval { $installed->version($module) };
    die $@ if $@;

    +{
        name    => $module,
        version => defined $version ? "$version" : undef,
    };
} @module_names;

my $data = {
    perl_version => "$^V",
    modules      => \@modules,
};

print JSON::PP->new->canonical->pretty->encode($data);
