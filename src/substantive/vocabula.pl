#!/usr/bin/perl
use CGI;
use utf8;
no warnings 'layer';
require "dictionary.pl";

$query = new CGI;
print $query->header(-type => 'text/html',
-charset => 'utf-8');
if($query->param('key') eq "u45a"){
	our $word = from_dict($query->param('word'));
	$word =~ s/^\s*|\s*$//g;
	print "-".$word."-";
}