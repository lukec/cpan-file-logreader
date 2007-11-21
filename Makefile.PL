#!/usr/bin/perl -w
use warnings;
use strict;
use inc::Module::Install;

name            'File-LogReader';
author          'Luke Closs <file-logreader@5thplane.com>';
version_from    'lib/File/LogReader.pm';
build_requires  'Test::More';
requires        'Digest::SHA1';
requires        'YAML';
license         'perl';

# Auto-install all dependencies from CPAN
auto_install;

# Generate the Makefile
WriteAll;
