#!/usr/bin/perl
# AdventOfCode2020
# --- Day 16: Ticket Translation ---
# part1: 24021
# part1 took 10.80799 ms
# part2: 1289178686687
# part2 took 101.4840 ms
# Duration: 112.336 ms
#
use strict;
use warnings;
no warnings 'uninitialized';

use Array::Utils qw/:all/;
use Time::HiRes qw/gettimeofday tv_interval time/;
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE => 1;
use constant DEBUG => 0;

my $start_time = [gettimeofday];
END { print "Duration: ", tv_interval($start_time)*1000, " ms\n"; }

my $data_start = tell DATA;
my $start = 0;
my $end = 0;
my $runtime = 0;

my @diff = ();
my @result = ();
my @rules = ();
my @nearby = ();
my @your = ();
my @departures = ();

$start = time();
part1();
$end = time();
$runtime = sprintf("%.8s", ($end - $start)*1000);
print "part1 took $runtime ms\n";

$start = time();
part2();
$end = time();
$runtime = sprintf("%.8s", ($end - $start)*1000);
print "part2 took $runtime ms\n";

exit(0);


sub part1 {
  @diff = ();
  @result = ();
  @rules = ();
  @nearby = ();
  @your = ();
  load_data();

  #Find values in a row under nearby tickets that don't fall in rules
  for my $row (@nearby) {
    my @row=split/,/,$row;
    my $rowflag=TRUE;
    for my $val (@row) {
      # Check each value against each rule.  if no matches, then keep the value to sum for the result.
      #for (@rules)
      my $itemflag=FALSE;
      for my $array_ref (@rules) {
        if (($val >= $$array_ref[1] && $val <= $$array_ref[2]) ||
            ($val >= $$array_ref[3] && $val <= $$array_ref[4])) {
          $itemflag=TRUE;
          last;
        }
      } # rules loop
      unless ($itemflag) {
        push @result,$val;
        $rowflag=FALSE;
      }
    } # row loop
    if ($rowflag) {
      push @diff, $row;
    }
  } # nearby loop
  my $value_count = 0;
  for (@result) {
    $value_count+=$_;
  }
  print "part1: ",$value_count,"\n";
}

sub part2 {
  my @list = ();
  for my $array_ref (@rules) {
    push @list,$$array_ref[0];
  }
  my $max = 0;
  my %answer=();
  for my $row (@diff) {
    my @row=split/,/,$row;
    for my $index (0..$#row) {
      my $val = $row[$index];

      my %rulepass = ();
      for my $array_ref (@rules) {
        $rulepass{$$array_ref[0]}{$index}=0;
        if (($val >= $$array_ref[1] && $val <= $$array_ref[2]) ||
            ($val >= $$array_ref[3] && $val <= $$array_ref[4])) {
            $rulepass{$$array_ref[0]}{$index}=1;
        }
      } # rules loop

      for (@list) {
        if (not defined $answer{$_}{$index}){$answer{$_}{$index}=0}
        if (defined $rulepass{$_}{$index}) {
          $answer{$_}{$index}+=$rulepass{$_}{$index};
          if ($answer{$_}{$index} > $max){$max=$answer{$_}{$index}};
        }
      }

    } # index loop

  } # diff loop

  for my $rule (@list) {
    my @list = ();
    my $counter = 0;
    while (my ($key, $value) = each %{$answer{$rule}}) {
      if ($value==$max) {
        push @list, $key;
        $counter++;
      }
    }
    $answer{$rule}{COUNT}=$counter;
    $answer{$rule}{LIST}=\@list;
  }

  my $part2 = 1;
  my @prev = ();
  for my $counter (1..20) {
    for my $rule (@list) {
      if ($answer{$rule}{COUNT}==$counter) {
        if ($counter==1) {
          @prev = @{$answer{$rule}{LIST}};
        } else {
          my @list1 = @{$answer{$rule}{LIST}};
          my @temp = @list1;
          my @new = array_diff(@list1, @prev);
          @prev=@temp;
          $answer{$rule}{LIST}=\@new;
          if ($rule =~ /departure/) {
            #print $new[0], "  ";
            #$part2 *= $new[0];
          }
        }
      }
    }
  }
  
  #print Dumper(%answer), "\n";
  #my @val = map { @{$answer{$_}{LIST}} } grep { /^departure/ } @list; # 19 16 10 13 11 6
  
  my @val = map {  @{$answer{$_}{LIST}} } grep { /^departure/ } @list;
  #print "\@your:@your\n";
  #print "\@val:@val\n";
  for (@val) {
    $part2 *= $your[$_];
  }  
  
  print "part2: ", $part2, "\n";;
}

#113,53,97,59,139,73,89,109,67,71,79,127,149,107,137,83,131,101,61,103


sub load_data {
  ##### Load Data #####
  my $filename = '../data/google-16.txt';
  #my $filename = '../data/reddit-16.txt';
  open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  my $your=FALSE;
  my $nearby=FALSE;
  while (<$fh>) {
  #while (<DATA>) {
    chomp;
    if (/^(.*?): (\d+)-(\d+) or (\d+)-(\d+)$/) {
      my @array = [$1, $2, $3, $4, $5];
      push @rules, @array;  
      if ($1 =~ /departure/) {
        push @departures, @array;
      }
    }
    if (/your ticket:/) {
      $your=TRUE;
    }
    if (/nearby tickets:/) {
      $nearby=TRUE;
      $your=FALSE;
    }
    if (/(?:\d+,)+/) {
      if ($nearby) {
        push @nearby,$_;
      } elsif ($your) { 
        push @your,split/,/;
      }
    }
  }
  close $fh;
}


__DATA__
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12