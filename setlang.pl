#!/usr/bin/perl
use CGI;
use CGI::Cookie;
@available_langs = qw/en ru de la/;
$query = new CGI;
$lang = $query->param('lang');
$lang = grep(/^$lang$/g, @available_langs) ? $lang : 'en';
my $c = CGI::Cookie->new(-name => 'system_lang',
-value => $lang,
-expires => '+3M');
print "Set-Cookie: $c\n";
print "Content-Type: application/json\n\n";
print '{"status" : 200}';