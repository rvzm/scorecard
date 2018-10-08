#!/usr/bin/perl
# scorecard - A simple scorecard script

use strict;
use warnings;
use Path::Class;
use Term::ANSIColor;
use Scalar::Util qw(looks_like_number);
use autodie;
use Curses::UI;

my $file = file(default-game-score.txt);
