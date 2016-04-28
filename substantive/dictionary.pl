use utf8;
use Data::Dumper;
sub from_dict
{
	    my ($input) = @_;
	    my $fl = lc(($input =~ m/^./g)[0]);
	    my $file = "../dictionary/subst/$fl.txt";
	    open(my $fh, '<:encoding(UTF-8)', $file)
	    or die "Could not open file '$filename' $!";
	    while (my $row = <$fh>) {
		    chomp $row;
		    my @vars = split(/\s\|\s/, $row);
		    my $resp = @vars[1] =~ s/\([^\)]*\)|(I|II|II|IV|V)//rg;
		    if(@vars[0] =~ m/^$input$/g){
			    $input = $resp;
		    }
	    }
	    return $input;
}
1;