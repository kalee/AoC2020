#!/usr/bin/perl
# AdventOfCode2020
# --- Day 7: Handy Haversacks ---
#
# part1: 252
# part1 took 5.67331314086914 ms to execute
# part2: 35487
# part2 took 5.67851066589355 ms to execute

use strict;
use warnings;
no warnings qw<uninitialized>; 
use List::AllUtils qw(sum any);

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE  => 1;

my $start  = time();
my $end     = time();
my $runtime = "";
my (%contents);
my %hash = ();


load_data();

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
  print 'part1: ', sum map { gold($_) } keys %contents;
  print "\n";
}


sub part2 {
  print 'part2: ', count('shiny gold'), "\n";
}

sub gold  {
  my ($bag) = @_;
  any { $_->{col} eq 'shiny gold' || gold($_->{col}) } @{$contents{$bag}}
}

sub count { 
  my ($bag) = @_;
  sum map { $_->{n} * (1 + count($_->{col})) } @{$contents{$bag}}
}


# Just load the data into the hash, convert it to other formats in the part1 or part2 code
sub load_data {
  ##### Load Data #####
  #my $filename = '../data/google-7.txt';
  my $filename = '../data/reddit-7.txt';
  open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
  #while (<DATA>) {
  while (<$fh>) {
    chomp;
    my ($outer) = /^(\w+ \w+) bags contain/ or die "Parsing $. failed";
    push @{$contents{$outer}}, {%+} while /\b(?<n>\d+) (?<col>\w+ \w+) bag/g;
  }
  close $fh;
}


__DATA__
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.