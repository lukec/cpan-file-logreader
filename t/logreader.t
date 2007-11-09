#!/usr/bin/perl
use strict;
use warnings;
use Test::Simple qw/no_plan/;
# use File::Path qw/rmtree/;
use File::LogReader;

my $state_dir = "t/state.$$";
mkdir $state_dir or die "Can't mkdir $state_dir: $!";
# END { rmtree $state_dir if $state_dir }

Read_a_static_file: {
    my $content = "I am a file!\nMy spoon is too big!\n";
    my $test_file = write_file($content);

    Initial_read_without_state: {
        my $lr = File::LogReader->new( 
            filename => $test_file,
            state_dir => $state_dir,
        );
        ok 1;
        warn "#### 1: " . $lr->read_line;
        warn "#### 2: " . $lr->read_line;
        warn "#### 2: " . $lr->read_line;
        for (split $/, $content) {
            ok $lr->read_line eq $_, "content matches";
        }
       exit;
        ok !$lr->read_line, 'got to EOF';
        $lr->commit;
    }

    Subsequent_read: {
        my $lr = File::LogReader->new( 
            filename => $test_file,
            state_dir => $state_dir,
        );
        is $lr->read_line, undef, 'nothing new to read';
    }

}

exit;

sub write_file {
    my $filename = "t/tmp.$$";
    open(my $fh, ">$filename") or die "Can't open $filename: $!";
    print $fh shift;
    close $fh or die "Can't write $filename: $!";
    return $filename;
}
