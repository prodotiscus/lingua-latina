#!/usr/bin/perl
use CGI;
use utf8;
use JSON::PP;
no warnings 'layer';
sub content_with_scalars
{
    $data_file = @_[0];
    open(DAT, $data_file) || die("Could not open file!");
    @raw_data=<DAT>;
    my $text = "";
    foreach $raw (@raw_data) {
            $text .= $raw;
    }
    return eval('qq{'.$text.'}');
}
sub json_encode
{
	my ($hash) = @_;
	my $json = JSON::PP->new->allow_nonref;
	my $js = $json->sort_by(sub { $JSON::PP::a cmp $JSON::PP::b })->encode($hash);
	return $js;
}
sub declination
{
	my ($word) = @_;
        my $ending = ($word =~ m/(?<=,\s)[^\s,]\S*(?=\sm|\sf|\sn|\sm\sf|\sm\sn|\sm\sf\sn)/g)[0];
        my $artic = ($word =~ m/(?<=\s)([^\s,]|[^\s,]\s[^\s,]|[^\s,]\s[^\s,]\s[^\s,])$/g)[0];
        $word =~ s/,.*|\s//g;
        my $decl = "";
        # All declinations except 3
        my %simple_endings = (
		"1" => qr/ae$/,
		"2a" => qr/(?<!e)ri$|^i$/,
		"2b" => qr/(?<=e)ri$/,
		"4" => qr/us$/,
		"5" => qr/ei$/
        );
        my $simple_endings = \%simple_endings;
        my @simple_declinations = keys %simple_endings;
        foreach $declination (@simple_declinations) {
            if($ending =~ $simple_endings{$declination} and $decl == ""){
                 $decl = $declination;
            }    
        }
        # 3 declination
        my %thirdd_endings = (
		"3a" => qr/([euioa][qwrtpsdfghjklzxcvbnm]|[qwrtpsdfghjklzxcvbnm][euioa])is$/,
		"3b" => qr/^is$/
        );
        if($word =~ m/(e|al|ar)$/g and $decl == ""){$decl = "3c";}
        my $thirdd_endings = \%thirdd_endings;
        my @thirdd_declinations = keys %thirdd_endings;
        foreach $declination (@thirdd_declinations) {
            if($ending =~ $thirdd_endings{$declination} and $decl == ""){
		$decl = $declination;
            }    
        }
        if($ending =~ m/[qwrtpsdfghjklzxcvbnm][qwrtpsdfghjklzxcvbnm]is$/){$decl = "3b";}
        # 3 genitive
        $gen = $decl =~ m/3/ ? gen3($word, $ending) : $word;
        return ($decl, $word, $gen);
}
sub gen3
{
    my ($gnom, $ggen) = @_;
    my ($nom, $gen) = ($gnom, $ggen);
    # 3a declination
    if($gen =~ m/([euioa][qwrtpsdfghjklzxcvbnm]|[qwrtpsdfghjklzxcvbnm][euioa])is$/){
        $gen =~ s/is$//g;
        my $sc = () = ($gen =~ /[euioa]/g);
        $nom =~ s/([euioa]([qwrtpsdfghjklzxcvbnm]*|)){$sc}$//g;
        $nom .= $ggen;
        return $nom;
    }
    if($gen =~ m/[qwrtpsdfghjklzxcvbnm][qwrtpsdfghjklzxcvbnm]is$/ and $nom =~ m/[qwrtpsdfghjklzxcvbnm][qwrtpsdfghjklzxcvbnm]$/){
        return $gen;
    }
    if($gen =~ m/^is$/){
        $nom =~ s/is$//g;
        return $nom . $gen;
    }
}
#
$query = new CGI;
print $query->header(-type => 'application/json',
-charset => 'utf-8');

if($query->param and $query->param('word') ne ''){
	our $word = $query->param('word');
	our @wdata = declination($word);
	if($query->param('format') eq "json"){
		my $out = {
			'query' => {
				'declination' => @wdata[0],
				'nom' => @wdata[1],
				'gen' => @wdata[2]
				
			},
			'status' => {
				'type' => 'correct',
				'code' => 'ALL_PARAMS_FOUND'
			}
			
		};
		print $query->param('callback') . "(";
		print json_encode($out);
		print ")";
	}
}else{
    my $out = {
	'query' => {},
	'status' => {
		'type' => 'error',
		'code' => 'NOPARAMS'
	}
   };
   print $query->param('callback') . "(";
   print json_encode($out);
   print ")";
}