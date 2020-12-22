#!/usr/bin/perl
# AdventOfCode2020
# --- Day 5: Binary Boarding ---
# part1: 878
# part2 took 2.07071304321289 ms to execute
# part2: 504
# part2 took 3.32241058349609 ms to execute

# FBFBBFFRLR
# Translate to binary: row=0101100
# 32+8+4 = row 44
# col = 101
# 4+1 = col 5

use strict;
use warnings;

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE  => 1;
use constant TOTAL => 150;

my $start  = time();
my @passports = ();
my $end     = time();
my $runtime = "";

my %hash = ();


part1();
$end     = time();
$runtime = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part2 took $runtime ms to execute\n";

part2();
$end     = time();
$runtime = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part2 took $runtime ms to execute\n";


exit(0);


sub part1 {
  load_datah();
  my @keys = sort keys %hash;
  for (@keys) {
    my @string = split //;
    my @rows = (0..127);
    my @seats = (0..7);
    for (@string) {
      my $rowcount = scalar @rows;
      my $seatcount = scalar @seats;
      if (/F/) {
        # Lower half
        @rows = @rows[0..($rowcount/2-1)];
        #print $_," 0-",$count/2-1,"\n";
      } elsif (/B/) {
        # upper half
        @rows = @rows[($rowcount/2)..($rowcount-1)];
        #print $_," ",$rowcount/2,"-",$rowcount-1,"\n";
      } elsif(/L/) {
        @seats = @seats[0..($seatcount/2-1)];
        #Lower half 4-5 for the row
      } elsif(/R/) {
        #upper half 4-7 for the row
        @seats = @seats[($seatcount/2)..($seatcount-1)];
      }
    }
    $hash{$_}=$rows[0]*8+$seats[0];
  }
  my $max=0;
  for (@keys) {
    if ($hash{$_}>$max) {
      $max=$hash{$_};
    }
  }
  print "part1: $max\n";
}

sub part2 {
  load_datah();
  my @keys = sort keys %hash;
  for (@keys) {
    my @string = split //;
    my @rows = (0..127);
    my @seats = (0..7);
    for (@string) {
      my $rowcount = scalar @rows;
      my $seatcount = scalar @seats;
      if (/F/) {
        # Lower half
        @rows = @rows[0..($rowcount/2-1)];
        #print $_," 0-",$count/2-1,"\n";
      } elsif (/B/) {
        # upper half
        @rows = @rows[($rowcount/2)..($rowcount-1)];
        #print $_," ",$rowcount/2,"-",$rowcount-1,"\n";
      } elsif(/L/) {
        @seats = @seats[0..($seatcount/2-1)];
        #Lower half 4-5 for the row
      } elsif(/R/) {
        #upper half 4-7 for the row
        @seats = @seats[($seatcount/2)..($seatcount-1)];
      }
    }
    #print "row: $rows[0]\n";
    #print "seat: $seats[0]\n";
    $hash{$_}=$rows[0]*8+$seats[0];
  }
  
  my @values = sort values %hash;
  my %values = map { $_ => 1 } @values;
  for (@values) {
    if (not exists $values{$_+1} and exists $values{$_+2} ) {
      print "part2: ",$_+1, "\n";
    }
  }
}


# Read into hash
sub load_datah {
  ##### Load Data #####
  my $filename = '../data/google-5.txt';
  #my $filename = '../data/reddit-5.txt';
  open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
  #while (<DATA>) {
  while (<$fh>) {
    chomp;
    $hash{$_}=0
  }
  close $fh;
}

__DATA__
FBFBBFFRLR
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL