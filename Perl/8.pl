#!/usr/bin/perl
# AdventOfCode2020
# --- Day 8: Handheld Halting ---
#part1: 2058
#part1 took 9.29903984069824 ms to execute
#part2: 1000
#part2 took 2.93660163879395 ms to execute


use strict;
use warnings;

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE  => 1;
use constant TOTAL => 150;

my $start  = time();
my $end     = time();
my $runtime = "";

my @data = ();


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
  my %visited = ();
  my $accumulater = 0;
  load_data();
  #print Dumper(@data),"\n";
  my $counter = 0;
  my $max=scalar @data;
  while ($counter< $max) {
    if (defined $visited{$counter}) {
      # visited this before, exit
      last;
    } else {
      $visited{$counter} = 1;
    }
    my $data = $data[$counter];
    my ($inst, $arg) = @$data;
    if ($inst eq "acc") {
      $accumulater += $arg;
      $counter++;
    } elsif ($inst eq "jmp") {
      $counter += $arg; 
    } elsif ($inst eq "nop") {
      # Do nothing
      $counter++;
    }
    #print $counter," ",@{$data[$counter]}," ",$inst," ", $arg,"\n";
  }
  print "part1: $accumulater\n";
}

# go through all records, change nop to jmp 
# and jmp to nop and test 
sub part2 {
  #@data = ();
  #load_data();
  my $max = scalar @data;
  #print "\$max:$max\n";
  my $counter = 0;
  while ($counter<$max) {
    my $data = $data[$counter];
    my ($inst, $arg) = @$data;
    if ($inst eq "nop") {
      $inst = "jmp";
      @$data = ($inst, $arg);
      #print "before: \$data:@$data\n";
      my $value = test_value();
      #print "\$value:$value\n";
      if ($value != 0) {
        print "part2: $value\n";
        last;
      }
      #put it back
      $inst = "nop";
      @$data = ($inst, $arg);
      #print "after: \$data:@$data\n";
    }
    $counter++;
    #print "\$counter:$counter\n";
  }

  $counter = 0;
  while ($counter<$max) {
    my $data = $data[$counter];
    my ($inst, $arg) = @$data;
    if ($inst eq "jmp") {
      $inst = "nop";
      @$data = ($inst, $arg);
      #print "before: \$data:@$data\n";
      my $value = test_value();
      #print "\$value:$value\n";
      if ($value != 0) {
        print "part2: $value\n";
        last;
      }
      #put it back
      $inst = "jmp";
      @$data = ($inst, $arg);
      #print "after: \$data:@$data\n";
    }
    $counter++;
    #print "\$counter:$counter\n";
  }
} 

sub test_value {
  my %visited = ();
  my $accumulater = 0;
  #load_data(); # use @data array
  my $counter = 0;
  my $max=scalar @data;
  while ($counter< $max) {
    if (defined $visited{$counter}) {
      $accumulater=0;  # signal that this didn't work
      last;
    } else {
      $visited{$counter} = 1;
    }
    my $data = $data[$counter];
    my ($inst, $arg) = @$data;
    if ($inst eq "acc") {
      $accumulater += $arg;
      $counter++;
    } elsif ($inst eq "jmp") {
      $counter += $arg; 
    } elsif ($inst eq "nop") {
      # Do nothing
      $counter++;
    }
    #print $counter," ",@{$data[$counter]}," ",$inst," ", $arg,"\n";
  }
  return $accumulater;
}



# Just load the data into the hash, convert it to other formats in the part1 or part2 code
sub load_data {
  ##### Load Data #####
  my $filename = '../data/google-8.txt';
  #my $filename = '../data/reddit-8.txt';
  open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
  #while (<DATA>) {
  while (<$fh>) {
    chomp;
    my ($inst, $arg) = /^(\w{3}) ([+|-]\d{1,3})$/;
    #print "debug: $inst, $arg","\n";
    my @dat = ($inst, $arg);
    push@data,\@dat;
  }
  close $fh;
}


__DATA__
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6