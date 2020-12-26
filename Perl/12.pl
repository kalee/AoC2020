#!/usr/bin/perl
# AdventOfCode2020
# --- Day 12: Rain Risk ---
#
#part1: 582
#part1 took 9.05 ms
#part2: 52069
#part2 took 1.010894 ms
#Duration: 10.101ms
#
use strict;
use warnings;
no warnings 'uninitialized';

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

my @data = ();

$start = time();
part1();
$end = time();
$runtime = sprintf("%.4s", ($end - $start)*1000);
print "part1 took $runtime ms\n";

$start = time();
part2();
$end = time();
$runtime = sprintf("%.8s", ($end - $start)*1000);
print "part2 took $runtime ms\n";

exit(0);


sub part1 {
  @data=();
  load_data();
  #draw(\@seat) if DEBUG;
  my $x = 0;
  my $y = 0;
  my $direction = 0;
  for (@data) {
    my ($command, $amount) = /(\w)(\d+)/;
    #print "\$command:$command|\$amount:$amount\n";
    if ($command =~ /F/) {
      if ($direction==0) {$x+=$amount}
      if ($direction==1) {$y+=$amount}
      if ($direction==2) {$x-=$amount}
      if ($direction==3) {$y-=$amount}
    } elsif ($command =~ /N/) {
      $y+=$amount;
    } elsif ($command =~ /S/) {
      $y-=$amount;
    } elsif ($command =~ /E/) {
      $x+=$amount;
    } elsif ($command =~ /W/) {
      $x-=$amount;
    } elsif ($command =~ /R/) {
      if ($amount == 90) {$direction-=1}
      if ($amount == 180) {$direction-=2}
      if ($amount == 270) {$direction-=3}
      $direction=$direction%4;
    } elsif ($command =~ /L/) {
      if ($amount == 90) {$direction+=1}
      if ($amount == 180) {$direction+=2}
      if ($amount == 270) {$direction+=3}
      $direction=$direction%4;
    }
    #print "\$direction:$direction|\$x:$x|\$y:$y\n";
  }
  print "part1: ",abs($x)+abs($y),"\n";
}


sub part2 {  # 48447, too low; needs to be 52069
  # waypoint is fixed.  10 units east, 1 unit north, fixed.
  @data=();
  seek DATA, $data_start, 0;  # reposition the filehandle right past __DATA__
  load_data();
  #draw(\@seat) if DEBUG;
  my $x = 0;
  my $y = 0;
  my $wpx = 10;
  my $wpy = 1;
  for (@data) {
    my ($command, $amount) = /(\w)(\d+)/;
    #print "\$command:$command|\$amount:$amount\n";
    if ($command =~ /F/) {
      $x+=($amount*$wpx);
      $y+=($amount*$wpy);
    } elsif ($command =~ /N/) {
      $wpy+=$amount;
    } elsif ($command =~ /S/) {
      $wpy-=$amount;
    } elsif ($command =~ /E/) {
      $wpx+=$amount;
    } elsif ($command =~ /W/) {
      $wpx-=$amount;
    } elsif ($command =~ /R/) {
      if ($amount == 90) {
        my $temp = $wpx;
        $wpx=$wpy;
        $wpy=-$temp;
      }
      if ($amount == 180) {
        $wpx=-$wpx;
        $wpy=-$wpy;
      }
      if ($amount == 270) {
        my $temp = $wpx;
        $wpx=-$wpy;
        $wpy=$temp;
      }
    } elsif ($command =~ /L/) {
      if ($amount == 90) {
        my $temp = $wpx;
        $wpx=-$wpy;
        $wpy=$temp;
      }
      if ($amount == 180) {
        $wpx=-$wpx;
        $wpy=-$wpy;
      }
      if ($amount == 270) {
        my $temp = $wpx;
        $wpx=$wpy;
        $wpy=-$temp;
      }
    }
    #print "\$direction:$direction|\$x:$x|\$y:$y|\$wpx:$wpx|\$wpy:$wpy\n";
  }
  print "part2: ",abs($x)+abs($y),"\n";

}


sub draw {
  my ($array) = (@_);
  my @array = @$array;  # dereference the array
  for my $line_ref (@array) {
    for (@$line_ref) {
      print "$_";
    }
    print "\n";
  }  
}

sub load_data {
  ##### Load Data #####
  my $filename = '../data/google-12.txt';
  #my $filename = '../data/reddit-12.txt';
  open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
  while (<$fh>) {
  #while (<DATA>) {
    chomp;
    push @data,$_;
  }
}


__DATA__
F10
N3
F7
R90
F11