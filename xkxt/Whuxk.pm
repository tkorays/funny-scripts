package xkxt::Whuxk;

use strict;
use warnings;
use LWP;
use LWP::Simple;
use LWP::UserAgent;
use HTTP::Cookies;
use Encode;
use URI::Escape;

sub new{
	my($class,$ref) = @_;
	
	my $ua = LWP::UserAgent->new;
	$ua->agent("Mozilla/5.0 (Windows NT 6.1; rv:30.0) Gecko/20100101 Firefox/30.0");
	$ua->timeout(100);
	my $cookie_jar = HTTP::Cookies->new(
		file=>$$ref{cookie},
		autosave=>1,
		ignore_discard=>1);
	$ua->cookie_jar($cookie_jar);
	
	my $self = bless({
		id=>$$ref{id},
		pwd=>$$ref{pwd},
		userAgent=>$ua,
		baseUrl=>'http://xk.whu.edu.cn',
		captcha=>''
	},$class);
	return $self;}
sub conf_baseurl{
	my($self,$baseurl) = @_;
	if($baseurl ne ""){
		$self->{baseUrl} = $baseurl;
	}}
sub get_captcha{
	my($self,$fn) = @_;
	my $res = $self->{userAgent}->get($self->{baseUrl}.'/GenImg');
	if(!$res->is_success){
		return 0;	}
	open(FILE_HANDLE,'>'.$fn);
	binmode FILE_HANDLE;
	print FILE_HANDLE $res->content;
	close FILE_HANDLE;
	1;	}
sub set_captcha{
	my($self,$cap) = @_;
	$self->{captcha} = $cap;}
sub login{
	my $self = shift;
	my $res = $self->{userAgent}->post($self->{baseUrl}.'/servlet/Login',{
		who=>'student',
		id=>$self->{id},
		pwd=>$self->{pwd},
		yzm=>$self->{captcha},
		submit=>encode('gb2312',decode('utf8',"确 定"))	});
	if($res->header('Location') eq $self->{baseUrl}.'/stu/newstu_index.jsp'){
		return 1;
	}
	0;}
sub test{
	my $self = shift;
	my $resp = $self->{userAgent}->get("http://www.baidu.com");
	#print $resp->content;
	print $self->{baseUrl}.'/GenImg';
}
1;