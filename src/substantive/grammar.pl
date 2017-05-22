use Data::Dumper;
use utf8;
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
        return ($decl, $word, $gen, $artic);
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
        $nom .= $ggen =~ s/^[qwrtpsdfghjklzxcvbnm]//r;
        return $nom;
    }
    if($gen =~ m/[qwrtpsdfghjklzxcvbnm][qwrtpsdfghjklzxcvbnm]is$/){
        if(length($gen) >= length($nom)){
            return $gen;
        }elsif($nom =~ m/er$/g){
             $nom =~ s/.er$/$gen/g;
             return $nom;
        }
    }
    if($gen =~ m/^is$/){
        $nom =~ s/is$//g;
        return $nom . $gen;
    }
}
1;