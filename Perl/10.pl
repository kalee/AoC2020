#!/usr/bin/perl
# AdventOfCode2020
# --- Day 10: Adapter Array ---
# part1: 1656
# part1 took 2.53369808197021 ms to execute
# part2: 56693912375296
# part2 took 2.56099700927734 ms to execute
#

use strict;
use warnings;
no warnings 'uninitialized';

use Time::HiRes qw( time );
use Data::Dumper;
use List::AllUtils  qw(max);

use constant FALSE => 0;
use constant TRUE  => 1;

my $start  = time();
my $end     = time();
my $runtime = "";

my @data = ();
my %hash = ();
my %sum = ();
load_data();  # Just do this once

part1();
$end     = time();
$runtime = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part1 took $runtime ms to execute\n";

part2();
$end     = time();
$runtime = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part2 took $runtime ms to execute\n";

exit(0);


sub part1 {
  my $counter = 0;
  my %diff = ();
  my @sorted = sort {$a <=> $b} @data;
  #print join ",",@sorted;
  #print "\n";
  for (@sorted) {
    my $diff = $_-$counter;
    #print "\$diff:$diff","\n";
    if (defined $diff{$diff}) {
      $diff{$diff}+=1;
    } else {
      $diff{$diff}=1;
    }
    $counter=$_;
  }
  $diff{3}+=1;
  #print "part1: ", $diff{1}," ", $diff{3}," ",$diff{1}*$diff{3}, "\n";
  #print "part1: $part1answer\n";
  print "part1: ", $diff{1}*$diff{3}, "\n";
}

sub part2 {
  my @sorted = sort {$b <=> $a} @data;  #descending order
  my $max=$sorted[0];
  $max+=3;
  push @sorted,0; # put 0 at the end
  unshift @sorted,$max; # put max+3 at the beginning
  #print join ",",@sorted;
  #print "\n";
  my $counter = 0;
  %sum = ();
  # 22,19,16,15,12,11,10,7,6,5,4,1,0
  for (@sorted) {
    $sum{$_}=0;
    if ($_==$max) {
      $sum{$_}=1;
    } else {

      if (defined $sorted[$counter-1]) {
        my $index=$sorted[$counter-1];
        if ($index-$_<4) {
          #print "\$counter:$counter|\$index:$index\n";
          $sum{$_} += $sum{$index};
        } else {
          $sum{$_} += 0;
        }
        #print $sum{$_}," ";
      }

      if (defined $sorted[$counter-2]) {
        #print "prev2-curr: ", $sorted[$counter-2]-$_, "\n";
        my $index=$sorted[$counter-2];
        if ($index-$_<4) {
          $sum{$_} += $sum{$index};
        } else {
          $sum{$_} += 0;
        }
        #print $sum{$_}," ";
      }

      if (defined $sorted[$counter-3]) {
        #print "prev3-curr: ", $sorted[$counter-3]-$_, "\n";
        my $index=$sorted[$counter-3];
        if ($index-$_<4) {
          $sum{$_} += $sum{$index};
        } else {
          $sum{$_} += 0;
        }
        #print $sum{$_}," ","\n";
      }

    }
    #print $sum{$_}, "\n";
    $counter++;
  }
  #print Dumper(%sum), "\n";
  print "part2: ",$sum{0}, "\n";
  #print "'0'",$sum{'0'}, "\n";
}



# Just load the data into the hash, convert it to other formats in the part1 or part2 code
sub load_data {
  ##### Load Data #####
  my $filename = '../data/google-10.txt';
  #my $filename = '../data/reddit-10.txt';
  open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
  #while (<DATA>) {
  while (<$fh>) {
    chomp;
    push @data, $_;
  }
  close $fh;
}


__DATA__
16
10
15
5
1
11
7
19
6
12
4