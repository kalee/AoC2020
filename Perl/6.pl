#!/usr/bin/perl
# AdventOfCode2020
# --- Day 6: Custom Customs ---
#part1: 6565
#part1 took 1.47819519042969 ms to execute
#part1: 3137
#part2 took 2.37588882446289 ms to execute

use strict;
use warnings;

use Time::HiRes qw( time );
use Data::Dumper;

use constant FALSE => 0;
use constant TRUE  => 1;

my $start  = time();
my $end     = time();
my $runtime = "";

my %hash = ();
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


#The first group contains one person who answered "yes" to 3 questions: a, b, and c.
#The second group contains three people; combined, they answered "yes" to 3 questions: a, b, and c.
#The third group contains two people; combined, they answered "yes" to 3 questions: a, b, and c.
#The fourth group contains four people; combined, they answered "yes" to only 1 question, a.
#The last group contains one person who answered "yes" to only 1 question, b.
#In this example, the sum of these counts is 3 + 3 + 3 + 1 + 1 = 11.
sub part1 {
  # Anyone answered "Yes"
  @data=();
  load_data();
  my $counter=0;
  for (@data) {
    %hash = ();
    my @questions = split/\n/;
    for (@questions) {
      my @answers = split//;
      for (@answers) {
        #print $_, " ";
        if (not defined $hash{$_}) {
          $hash{$_}=1;
        } else {
          $hash{$_}+=1;
        }
      }
    }
    #print "\n";
    my @keys = sort keys %hash;
    $counter += scalar @keys;
  }
  
  print "part1: $counter","\n";
}


sub part2 {
  my $counter=0;
  my $groupcount = scalar @data;
  #print "there are $groupcount groups\n";
  for my $data (@data) {
    my @questions = split/[\n]/,$data;
    my $questioncount = scalar @questions;
    #print "\$data:$data"," ","\$questioncount:$questioncount"," ", "\n";
    %hash = ();
    my $cnt=0;
    for my $question (@questions) {
      $cnt++;
      my @list=split//,$question;
      #print "\$cnt:$cnt"," ","\$data:$data"," ","\$question:$question"," ","\$questioncount:$questioncount"," ","\@list:@list"," ", "\n";
      $hash{$cnt}=\@list;
      #print Dumper(%hash),"\n";
    }
    #print "$_\n" for construct_arr(\%hash);
    my @result = construct_arr(\%hash);
    my $count = scalar @result;
    $counter += $count;
  }
 print "part1: $counter","\n"; 
}

sub construct_arr {
  my $records = shift;
  my %seen;
  $seen{$_}++ for map @$_, values %$records;
  grep $seen{$_} == keys %$records, keys %seen;
}



# Just load the data into the hash, convert it to other formats in the part1 or part2 code
sub load_data {
  ##### Load Data #####
  my $filename = '../data/google-6.txt';
  #my $filename = '../data/reddit-6.txt';
  open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";
  #while (<DATA>) {
  #while (<$fh>) {
  my $file_content = do { local $/; <$fh> };
  close $fh;
  #my $file_content = do { local $/; <DATA> };
  @data = split/\n\n/,$file_content;
  #}
  
}


__DATA__
abc

a
b
c

ab
ac

a
a
a
a

b