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


my $email = '***@**.com';
my $password = '***';
my $domain = 'renren.com';
my $hostid='';
my $requestToken='';
my $rtk='';
my $channel='renren';

my $ua = LWP::UserAgent->new;
$ua->agent("Mozilla/5.0 (Windows NT 6.1; rv:30.0) Gecko/20100101 Firefox/30.0");
my $cookie_jar = HTTP::Cookies->new(
	file=>'lwp_cookies.txt',
	autosave=>1,
	ignore_discard=>1);
$ua->cookie_jar($cookie_jar);

my $login_url = 'http://www.renren.com/PLogin.do';
my $res = $ua->post($login_url,{
		'email'=>$email,
		'password'=>$password,
		'domain'=>$domain});
my $homepage;	
if($res->header('Location') eq 'http://www.renren.com/Home.do'){
	print 'login ok...',"\n";
	$homepage = $ua->get('http://www.renren.com/home'); 
}else{
	exit;
}
if($homepage->is_success){
	my $pagect = $homepage->content;
	$pagect =~ /id\s:\s"(\d+)"/g;
	$hostid = $1;
	$pagect =~ /requestToken\s:\s'(.+)'/g;
	$requestToken = $1;
	$pagect =~ /_rtk\s:\s'(.+)'/;
	$rtk = $1;
	
			
}else{
	exit;	
}

my $purl = 'http://shell.renren.com/'.$hostid.'/status';
my ($sec,$min,$hour,$day,$mon,$year,$wday,$yday,$isdst) = localtime(); 
$year +=1900;
$mon++;
my $postret = $ua->post($purl,{
	'content'=>"renren test,by perl script,author:tkorays,date:$year-$mon-$day $hour:$min:$sec.",
	'hostid'=>$hostid,
	'requestToken'=>$requestToken,
	'_rtk'=>$rtk,
	'channel'=>$channel});
if($postret->is_success){
	print 'send ok...',"\n";
}else{
	print 'fuck!';
}

