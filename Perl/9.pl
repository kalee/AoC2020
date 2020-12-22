#!/usr/bin/perl
# AdventOfCode2020
#
# --- Day 9: Encoding Error ---
#part1: 556543474
#part1 took 4.51350212097168 ms to execute
#part2: 76096372
#part2 took 0.00010143518447 ms to execute


use strict;
use warnings;
use Algorithm::Combinatorics qw(:all);
use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE  => 1;
use constant PREAMBLE => 25;

my $start  = time();
my $end     = time();
my $runtime = "";

my @data = ();
my %hash = ();

@data=();
load_data();

my $part1 = part1();
$end      = time();
$runtime  = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part1: $part1\n";
print "part1 took $runtime ms to execute\n";

my $part2 = part2();
$end      = time();
$runtime  = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part2: $part2\n";
print "part2 took $runtime ms to execute\n";

exit(0);



sub part1 {
  my $counter = 0;
  my @preamble = ();
  my $max = scalar @data;
  $counter=PREAMBLE;
  while ($counter<$max) {
    my $flag=FALSE;
    my @slice = @data[$counter-PREAMBLE..$counter-1];
    my $iter = combinations(\@slice,2);
    while (my $c = $iter->next) {
      my ($a,$b) = @$c;
      #print "\$a \$b:$a $b\n";
      if ($a+$b==$data[$counter]) {
        $flag=TRUE;
        last;
      }
    }
    unless ($flag) {
      return $data[$counter];
      last;
    }
    $counter++;
  }
}

sub part2 {
  #@data=();
  #load_data();
  my $part1=part1();
  my @test = ();
  my $max = scalar @data;
  my $counter=2;  
  while ($counter<$max) {
    for my $cnt (0..$max-$counter) {
      my @test=@data[$cnt..$cnt+$counter];
      my $sum=0;
      for (@test) {
        $sum+=$_;
      }
      #print "\$counter:$counter","|","\@test:@test", "\n";
      if ($sum==$part1) {
        print '$sum==$part1',"\n";
        my @asc = sort {$a <=> $b} @test;
        my @des = sort {$b <=> $a} @test;
        return $asc[0]+$des[0];
      }
    }
    $counter++;
  }
}


# Just load the data into the hash, convert it to other formats in the part1 or part2 code
sub load_data {
  ##### Load Data #####
  #my $filename = '../data/google-9.txt';
  my $filename = '../data/reddit-9.txt';
  open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
  #while (<DATA>) {
  while (<$fh>) {
    chomp;
    push @data,$_;
  }
  close $fh;
}


__DATA__
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576