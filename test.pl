#!/usr/bin/perl

push (@INC,'xkxt');
use xkxt::Whuxk;


my $whuer = xkxt::Whuxk->new({id=>'2011301200047',pwd=>'22000414',cookie=>'lwp_cookies.txt'});
$whuer->conf_baseurl('http://202.114.74.198'); 
$whuer->get_captcha('a.jpg');
print 'input captcha:';
chomp(my $cap=<STDIN>);
$whuer->set_captcha($cap);
print $whuer->login;