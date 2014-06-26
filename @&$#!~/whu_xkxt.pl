#!/usr/bin/perl

# Copyright 2014 tkorays. All rights reserved.
# author tkorays
# email tkorays@hotmail.com

use strict;
use warnings;
use LWP;
use LWP::Simple;
use LWP::UserAgent;
use HTTP::Cookies;
use HTTP::Headers;
use HTTP::Response;
use Encode;
use URI::Escape;
use URI::URL;

my $ua = LWP::UserAgent->new;
$ua->agent("Mozilla/5.0 (Windows NT 6.1; rv:30.0) Gecko/20100101 Firefox/30.0");
$ua->timeout(100);
my $cookie_jar = HTTP::Cookies->new(
	file=>'lwp_cookies.txt',
	autosave=>1,
	ignore_discard=>1);
$ua->cookie_jar($cookie_jar);

my $whu_id = '你的whu学号';
my $whu_pwd = '你的密码';
my $captcha = '';
my $url = 'http://202.114.74.198';
my $form_submit = encode('gb2312',decode('utf8',"确 定"));
my $captcha_url = $url.'/GenImg';
my $pres = $ua->get($captcha_url);
open(FILE_HANDLE,'>img.jpg');
binmode FILE_HANDLE;
print FILE_HANDLE $pres->content;
close FILE_HANDLE;

###################################
# input info
print 'input your id:',"\n";
#chomp($whu_id = <STDIN>);
die "\n***please input your id***\n" unless $whu_id;
print 'input your password:',"\n";
#chomp($whu_pwd =  <STDIN>);
die "\n***please input your password***\n" unless $whu_pwd;
print 'input captcha:',"\n";
chomp($captcha = <STDIN>);
die "\n***please input captcha***\n" unless $captcha;

my $res = $ua->post($url.'/servlet/Login',{
		'who'=>'student',
		'id'=>$whu_id,
		'pwd'=>$whu_pwd,
		'yzm'=>$captcha,
		'submit'=>$form_submit
});
if($res->header('Location') eq $url.'/stu/newstu_index.jsp'){
	print "login success!\n";
}else{
	exit;
}

# get lessons

my $lessonpage = $ua->get($url.'/stu/query_stu_lesson.jsp');
die 'failed to open lesson page' unless $lessonpage->is_success;
my $pagect = $lessonpage->content;
$pagect =~ s/[\r\n\t]/ /g;
my $result;
my $t = encode('gb2312',decode('utf8',"姓名"));
$pagect =~ /$t:(.*?)&nbsp/;
print "\n\n",encode('gb2312',decode('utf8',"姓名")),": $1\n";
$t = encode('gb2312',decode('utf8',"学号"));
$pagect =~ /$t:(.*?)\s/;
print encode('gb2312',decode('utf8',"学号")),": $1\n";


print encode('gb2312',decode('utf8',"课程")),": \n";
my @allmatch = $pagect =~ /<tr[^>]*>(.*?)(?!\/tr>)<\/tr>/g;
foreach my $single(@allmatch){
	$result = $single =~ /<td width="80">(.*?)(?!\/td>)<\/td>/g;
	print $1,"\n" if $result;
}


