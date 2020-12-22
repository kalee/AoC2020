#!/usr/bin/perl
# AdventOfCode2020
# --- Day 3: Toboggan Trajectory --- 
#part1: 214
#part1 took 0.00085679602622 ms to execute
#part2: 8336352024
#94 214 99 91 46
#part2 took 0.01015240693092 ms to execute

use strict;
use warnings;

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE  => 1;
use constant TOTAL => 150;

my $start  = time();
my %points = ();
my $row = 0;
my $col = 0;


my $p1 = part1(3,1);
#print "\$col:$col|\$row:$row\n";
print "part1: $p1\n";
my $end     = time();
my $runtime = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part1 took $runtime ms to execute\n\n";

part2();
$end     = time();
$runtime = sprintf( "%.16s", ( $end - $start ) / 1000 );
print "part2 took $runtime ms to execute\n";

exit(0);

sub part1 {
  my ($a,$b) = @_;

  my $counter = 0;
  %points = ();
  #my $p = load_data(\%points);
  load_data();
  #%points = %$p;
  #print "$row:$row\n";

  my $x=0;
  my $y=0;
  my $key="";
  while ($y<=$row) {
    $x=$x+$a;
    $y=$y+$b;
    $key = "($x" . "," . "$y)";
    if (defined $points{$key}) {
      if ($points{$key} eq "#") {
        $points{$key}="X";
        $counter++
      } else {
        $points{$key}="O";
      }
    }
    
  }
  return $counter;
}

sub part2 {
  # Code goes here
  my $p1 = part1(1,1);
  my $p2 = part1(3,1);
  my $p3 = part1(5,1);
  my $p4 = part1(7,1);
  my $p5 = part1(1,2);
  my $part2 = $p1 * $p2 * $p3 * $p4 * $p5;
  print "part2: $part2\n";
  print "$p1 $p2 $p3 $p4 $p5\n";
}


sub print_state {
  #my ($p) = @_;
  #my %points = %$p;
  for my $i (0..$row-1) {
    for my $j (0..$col-1) {
      my $key = "($j" . "," . "$i)";
      print $points{$key};
    }
    print "\n";
  }
  print "\n";
}


sub load_data {
  #my ($p) = @_;
  #my %points = %$p;
  $col=0;
  $row=0;
  ##### Load Data #####
  my $filename = '../data/google-3.txt';
  #my $filename = '../data/reddit-3.txt';
  # Repeat to the right 4 times.
  open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
  #while (<DATA>) {
  while (<$fh>) {
    chomp;

    $_="$_"x100;

    my @data = split '', $_;
    for my $data (@data) {
        my $colrow = "($col" . "," . "$row)";
        if ($data eq '#') {
            $points{$colrow}='#';
        } else {
            $points{$colrow}='.';
        }
        $col += 1;
    }
    $col = 0;
    $row += 1;
  }
  close $fh;
  #return \%points;
}


__DATA__
..##.........##.........##.........##.........##.......
#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
.#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
.#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
..#.##.......#.##.......#.##.......#.##.......#.##.....
.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
.#........#.#........#.#........#.#........#.#........#
#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
#...##....##...##....##...##....##...##....##...##....#
.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#