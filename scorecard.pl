#!/usr/bin/perl
# scorecard - A simple scorecard script
# version 0.1 r1
use strict;
use warnings;
use Term::ANSIColor;
use Scalar::Util qw(looks_like_number);
use autodie;
use Getopt::Long;

my $debug = '';
my $file = "default-game-score.txt";
my $datfile = "scores.dat";

GetOptions(
	'display-file:s' => \&dispfile,
	'datfile|data|datafile|d:s' => \$datfile,
	'debug' => \$debug,
	'f|file|filename:s' => \$file);

sub dispfile()
{
	my ($opt_name, $dfile) = @_;
	open (my $fhd,'<',$dfile)
	 or die "Could not open file '",$dfile,"'.\n";
	chomp(my @ls = <$fhd>);
	my $gt = $ls[0];
	my $gn = $ls[1];
	my $gp = $ls[2];
	print "Game '",$gn,"' was started ",$gt," with ",$gp," players.\nthese were the scores:\n";
	for(my $i=3;$i<$gp;$i++){
		print $ls[$i];
		}
	close $fhd;
	die;
	}
sub run_start()
{
	open (my $fh,'>',$file)
	 or die "Could not open file '",$file,"'.\n";
	open (my $fhdx,'>',$datfile)
	 or die "Could not open file '",$datfile,"'.\n";
	print color("white"),"Welcome to scorecard\nA simple scorecard script\n\n",color("reset");
	print $fh "********************\n";
	print $fh "**********Scorecard*\n";
	print $fh "*A Simple Scorecard*\n";
	print $fh "********************\n";
	print $fh "Game Started ",scalar localtime,".\n\n";
	my $game = prompt("What game would you like to score?\n");
	my $pnum = prompt_num("How many players? ");
	print $fhdx scalar localtime,"\n",$game,"\n",$pnum,"\n";
	my @plist;
	for(my $i=0;$i<$pnum;$i++){
		push(@plist , prompt("Enter Player ".($i+1)." name\n"));
	}
    print "\n";
	my @pscore;
    for(my $i=0;$i<$pnum;$i++){
		push(@pscore, prompt_num("score for $plist[$i]?\n"));
    }
    print "\n";
	print $fh "Game: $game\n";
	for(my $i=0;$i<$pnum;$i++){
		print "$plist[$i]\n";
		print color('bright_green'),"$pscore[$i]",color('reset'),"\n";
		print $fh $plist[$i]," - ",$pscore[$i],"\n";
		print $fhdx $plist[$i]," - ",$pscore[$i],"\n";
		}
	close $fh;
	close $fhdx;
}

# prompt util subs
sub prompt {
    my ($query) = @_; # take a prompt string as argument
    local $| = 1; # activate autoflush to immediately show the prompt 
    print $query;
    chomp(my $answer = <STDIN>); return $answer;
}
sub prompt_num {
    NSTART:
    my ($querynum) = @_;
    print $querynum;
    chomp(my $pnum = <STDIN>);
    if (looks_like_number($pnum)) { return $pnum; }
    else { print "Error: That is not a number. Try again.\n"; goto NSTART; }
}
sub prompt_yn {
    my ($queryyn) = @_;
    my $answer = prompt("$queryyn (y/N): ");
    return lc($answer) eq 'y';
}

run_start();