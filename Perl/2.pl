#!/usr/bin/perl
# AdventOfCode2020
#part1: 600
#part1 took 1.97138786315918 ms to execute
#part2: 245
#part2 took 2.07228660583496 ms to execute

use strict;
use warnings;

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE  => 1;
use constant TOTAL => 150;

my $start  = time();
my %hash = ();
my $counter = 0;

##### Load Data #####
my $filename = '../data/google-2.txt';
#my $filename = '../data/reddit-2.txt';


open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
#while (<DATA>) {
while (<$fh>) {
  chomp;
  #1-3 a: abcde
  #1-3 b: cdefg
  #2-9 c: ccccccccc
  my ($begin, $end, $letter, $password) = /(\d{1,2})-(\d{1,2}) (\w): (\w+)/;
  #print "\$begin:$begin|\$end:$end|\$letter:$letter|\$password:$password\n";
  $hash{$counter}{START}=$begin;
  $hash{$counter}{END}=$end;
  $hash{$counter}{LETTER}=$letter;
  $hash{$counter}{PASSWORD}=$password;
  $counter++;
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
  # Code goes here
  my @keys = sort keys %hash;
  my $count=0;
  for (@keys) {
    my $password = $hash{$_}{PASSWORD};
    my $cnt = () = $password =~ /\Q$hash{$_}{LETTER}/g;
    my $result = $cnt >= $hash{$_}{START} && $cnt <= $hash{$_}{END};
    print "$_:$cnt|$hash{$_}{START}|$hash{$_}{END}\n";
    if ($cnt >= $hash{$_}{START} && $cnt <= $hash{$_}{END}) {
      $count++;
    }
  }
  print "part1: $count\n";

}

sub part2 {
  # Code goes here
  my @keys = sort keys %hash;
  my $count=0;
  for (@keys) {
    my $password = $hash{$_}{PASSWORD};
    if (substr($password, $hash{$_}{START}-1,1) eq $hash{$_}{LETTER} ^ substr($password, $hash{$_}{END}-1,1) eq $hash{$_}{LETTER} ) {
      $count++;
    }
  }
  print "part2: $count\n";
}

__DATA__
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc