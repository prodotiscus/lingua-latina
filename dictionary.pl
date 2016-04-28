#!/usr/bin/perl
use CGI;
use utf8;
use JSON::PP;
no warnings 'layer';
$query = new CGI;
print $query->header(-type => 'text/html',
-charset => 'utf-8');

my $word = $query->param('word');
my $fl = ($word =~ m/^./g)[0];
my $file = "/srv/dictionary/subst/$fl.txt";
open(my $fh, '<:encoding(UTF-8)', $file)
or die "Could not open file '$filename' $!";

while (my $row = <$fh>) {
	chomp $row;
	my @vars = split(/\s\|\s/, $row);
	my $resp = @vars[1];
	$resp =~ s/\s\([^\(\)]*\)|(I|II|II|IV|V)\s//g;
	if(@vars[0] =~ m/^$word$/g){
		print $resp."<BR>";
	}
}
