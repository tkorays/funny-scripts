#!/usr/bin/perl
# Copyright 2014 tkorays. All rights reserved.
# author tkorays
# email tkorays@hotmail.com

push (@INC,'xkxt');use xkxt::Whuer;
my $user = xkxt::Whuer->new('fuck','fff');
$user->test;
$user->login({cao=>'fff',id=>'adfadsfa'});
my %gg = (f=>'as',id=>'ff');
print "\n",$gg{f},"----";
print $gg[0]." ";
<>;