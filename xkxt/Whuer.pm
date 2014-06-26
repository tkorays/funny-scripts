package xkxt::Whuer;
use Carp ();
use strict;
use warnings;
use LWP;
use LWP::Simple;
use LWP::UserAgent;
use HTTP::Cookies;
use Encode;
use URI::Escape;
sub new{
	my ($class,$id,$pwd) =  @_;
	my $self = bless ({
		id=>$id,
		pwd=>$pwd
	}, $class);
	return $self;}
sub login{
	my ($self,%v) = @_;
	1;}
sub test{
	my $self = shift;
	print $self->{id};}
1;
