#!/usr/bin/perl
# scorecard - A simple scorecard script
# version 0.1 beta
use strict;
use warnings;
use Path::Class;
use Term::ANSIColor;
use Scalar::Util qw(looks_like_number);
use autodie;

my $file = file("default-game-score.txt");

sub run_start()
{
	my $fh = $file->openw();
	print color("white"),"Welcome to scorecard\nA simple scorecard script\n\n",color("reset");
	my $game = prompt("What game would you like to score?\n");
	my $player = prompt("What is the players name?\n");
	my $score = prompt_num("What is the players score?\n");
	print "\n",color("white"),"Current score for ",color("yellow"), $player,color("white"), " durring the game of ",color("red"), $game,color("white"), " is ",color("green"), $score,color("reset"), "\n";
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