#!/usr/bin/perl
use CGI;
use CGI::Cookie;
use File::Slurp;
$query = new CGI;
print $query->header(-type => 'text/html',
-charset => 'utf-8');
if($query->cookie('system_lang')) {
    $system_lang = $query->cookie('system_lang');
    $content = read_file('adjectivum.html');
    print $content;
}
else {
    print(read_file('../chooselang.html'));
}