#!/usr/bin/perl


use xkxt::Whuxk;



$whuer->conf_baseurl('http://202.114.74.198'); 
$whuer->get_captcha('a.jpg');
print 'input captcha:';
chomp(my $cap=<STDIN>);
$whuer->set_captcha($cap);
print $whuer->login;