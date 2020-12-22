#!/usr/bin/perl
# AdventOfCode2020
# --- Day 4: Passport Processing ---
#part1: 200
#part2 took 8.82983207702637 ms to execute
#part2: 116
#part2 took 1.32219791412354 ms to execute

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
  @passports = ();
  load_data();
  #print Dumper(@data);
  my $passportcounter = 0;
  for (@passports) {
    my @passport=split/[ \n]/;
    my $count = scalar @passport;
    my $passport=join ",",@passport;
    if ($passport =~ (/cid/)) {
      if ($count==8) {
        $passportcounter++;
      }
    } elsif ($count==7) {
      $passportcounter++;
    }
  }
  print "part1: $passportcounter\n";
}


sub part2 {
  @passports = ();
  load_data();
  my $passportcounter = 0;
  my $counter = 0;
  for (@passports) { # $_ a string of all key:val pairs in the current passport
    my @passport=split/[ \n]/; # @passport is an array of key:value entries in a single passport
    @passport = sort @passport;
    my $passport=join ",",@passport;  # $passport is the string of all key:value pairs in a single passport
    
    my %passport = ();
    for (@passport) { # $_ is a single key:value pair
      my ($key,$val)=split/:/,$_;
      $val =~ s/^\s+|\s+$//g;  #trim remove white space from both ends of a string
      $passport{$key}=$val;
    }
    for my $k ('byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid') {
      if (not defined $passport{$k}) {
        $passport{$k}=0;
      } 
    }

    my $valid = TRUE;

    unless ($passport{'byr'}>=1920 && $passport{'byr'}<=2002){$valid = FALSE}
    #unless ($valid) {print "failed byr:$passport\n";next}

    unless ($passport{'iyr'}>=2010 && $passport{'iyr'}<=2020){$valid = FALSE}
    #unless ($valid) {print "failed iyr:$passport\n";next}

    unless ($passport{'eyr'}>=2020 && $passport{'eyr'}<=2030){$valid = FALSE}
    #unless ($valid) {print "failed eyr:$passport\n";next}
    
    if ($passport{'hgt'}=~/in/) {
      my ($val) = $passport{'hgt'} =~ /(\d+)/;
      unless ($val>=59 && $val<=76){$valid = FALSE}
    } elsif ($passport{'hgt'}=~/cm/) {
      my ($val) = $passport{'hgt'} =~ /(\d+)/;
      unless ($val>=150 && $val<=193){$valid = FALSE}
    } else {
      $valid = 0;
    }
    #unless ($valid) {print "failed hgt:$passport\n";next}

    unless ($passport{'hcl'}=~/#[0123456789abcdef]{6}/){$valid = FALSE}
    #unless ($valid) {print "failed hcl:$passport\n";next}

    unless ($passport{'ecl'}=~/amb|blu|brn|gry|grn|hzl|oth/){$valid = FALSE} 
    #unless ($valid) {print "failed ecl:$passport\n";next}

    unless ($passport{'pid'}=~/^[0123456789]{9}$/){$valid = FALSE}
    #unless ($valid) {print "failed pid:$passport\n";next}

    if ($valid){$passportcounter++}

  }
  print "part2: $passportcounter\n";  
}



sub load_data {
  ##### Load Data #####
  my $filename = '../data/google-4.txt';
  #my $filename = '../data/reddit-4.txt';
  open( my $fh, '<:encoding(UTF-8)', $filename ) or die "Could not open file '$filename' $!";

  my $file_content = do { local $/; <$fh> };
  #my $file_content = do { local $/; <DATA> };
  @passports = split/\n\n/,$file_content;

  close $fh;
}


__DATA__
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in