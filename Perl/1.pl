#!/usr/bin/perl
# AdventOfCode2020
# --- Day 1: Report Repair ---
#part:1 32 1988 63616
#part1 took 1.02338790893555 ms to execute
#part2: 1051 897 72 67877784
#part2 took 0.00075995492935 ms to execute

use strict;
use warnings;

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE  => 1;
use constant TOTAL => 150;

my $start  = time();
my @values = ();

##### Load Data #####
my $filename = '../data/reddit-1.txt';

#my $filename = '../data/reddit-1.txt';
open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
while (<$fh>) {
  chomp;
  push @values, $_;
}
close $fh;


part1();
my $end     = time();
my $runtime = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part1 took $runtime ms to execute\n\n";

part2();
$end     = time();
$runtime = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part2 took $runtime ms to execute\n";

exit(0);

sub part1 {
  my $max = scalar @values;
  for my $v1 ( 0 .. $max - 1 ) {
    for my $v2 ( 0 .. $max - 1 ) {
      if ($v1 != $v2 && $values[$v1] + $values[$v2] == 2020 ) {
        print "part:1 ", $values[$v1], " ", $values[$v2], " ", $values[$v1] * $values[$v2], "\n";
      }
    }
  }
}

sub part2 {
  my $max = scalar @values;
  for my $v1 ( 0 .. $max - 1 ) {
    for my $v2 ( 0 .. $max - 1 ) {
      for my $v3 ( 0 .. $max - 1 ) {
        if ( $values[$v1] + $values[$v2] + $values[$v3] == 2020 ) {
          print "part2: ", $values[$v1], " ", $values[$v2], " ", $values[$v3], " ",
              $values[$v1] * $values[$v2] * $values[$v3], "\n";
        }
      }
    }
  }
}

__DATA__
