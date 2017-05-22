#!/usr/bin/perl
use CGI;
no warnings 'layer';
use utf8;
require 'interling.pl';
#
#
sub translate_interface {
    my ($text, $language) = @_;
    if($language ne 'ru') {
            my @russian = eval("keys %$language");
            my @other = eval("values %$language");
            for($i = 0; $i < scalar(@russian); $i ++) {
                my $rus = @russian[$i];
                my $oth = @other[$i];
                $text =~ s/$rus/$oth/g;
            }
    }
    return $text;
}
sub content_with_scalars
{
    my ($data_file) = @_;
    open(DAT, $data_file) || die("Could not open file!");
    @raw_data=<DAT>;
    my $text = "";
    foreach $raw (@raw_data) {
            $text .= $raw;
    }
    $text = eval('qq{' . $text . '}');
    $text = translate_interface($text, $system_lang);
    return $text;
}
#
require "grammar.pl";
require "dictionary.pl";
#
$query = new CGI;
print $query->header(-type => 'text/html',
-charset => 'utf-8');
our $system_lang = $query->cookie('system_lang');
our $dictionary = 0;
if ( $query->param('word') !~ m/,/g ) {
     $dictionary = 1;
}
if ($query->param) {
    if($query->param('word') and not $query->param('word') =~ m/\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-/g){
        ###
        our $word = $query->param('word');
        $word = $word =~ s/J/I/rg;
        $word =~ s/i(?=a|u)/j/g;
        if($word =~ m/(\d|\~|[йцукенгшщзхъфывапролджэячсмитьбюё])/g){
            $word = "undefined";
        }
        ### ADD UNICODE TO PROGRAM
        ###
        our @exc = ("agnus","balneum","bos","canis","deus","Deus","domus","femur","iecur","iter","Iuppiter","sitis",
        "venum","vicis","vis","vulgus");
        our $e = 0;
        if(grep(/^$word$/g, @exc)){
            print content_with_scalars("../subst/exc/$word.html");
            $e = 1;
            our $decl = "exception";
        }
        #
        if($dictionary and $e == 0){
            $word = from_dict($word);
            $word =~ s/^\s*|\s*$//g;
        }
        #
        if($e == 0){
            our @wdata = declination($word);
            our $decl = @wdata[0];
            our $gen = @wdata[2];
            $word = @wdata[1];
            our $sg = @wdata[1];
            our $gender = @wdata[3];
        }
        our %decls = (
            "1" => sub{
                        $word = $sg =~ s/a$//r;
                        $pl = $word . "ae";
                        print content_with_scalars("../subst/1.html");
                    },
            "2a" => sub{
                            $word = $sg =~ m/us$/g ? $sg =~ s/us$//rg : $sg =~ s/er$/r/rg =~ s/um$//rg;
                            $pl = $word . "i";
                            print content_with_scalars("../subst/2.html");
                    },
            "2b" => sub{
                            $word = $sg =~ m/us$/g ? $sg =~ s/us$//r : $sg;
                            $pl = $word . "i";
                            print content_with_scalars("../subst/2.html");
                    },
            "3a" => sub{
                            $word = $gen =~ s/is$//r;
                            our $pl_nom = $pl_acc = $gender eq "n" ? "a" : "es";
                            our $pl = $word . "es";
                            our $sg_acc_a = $gender eq "n" ? $sg : $word;
                            our $sg_acc_b = $gender eq "n" ? "" : "em";
                            print content_with_scalars("../subst/3a.html");
                    },
            "3b" => sub{
                            $word = $gen =~ s/is$//r;
                            our $pl_nom = $pl_acc = $gender =~ m/n/g ? "a" : "es";
                            our $pl = $word . "es";
                            our $sg_acc_a = $gender eq "n" ? $sg : $word;
                            our $sg_acc_b = $gender eq "n" ? "" : "em";
                            print content_with_scalars("../subst/3b.html");
                    },
            "3c" => sub{
                            $word = $sg;
                            $pl = $sg . "ia";
                            print $gender eq "n" ? content_with_scalars("../subst/3c.html") : content_with_scalars("../subst/3c_b.html");
                    },
            "4" => sub{
                            $word = $sg =~ s/u(s|)$//r;
                            $pl = $word . "us";
                            print $gender eq "n" ? content_with_scalars("../subst/4_n.html") : content_with_scalars("../subst/4_mf.html");
                    },
            "5" => sub{
                            $word = $sg =~ s/es$//r;
                            $pl = $word . "es";
                            print content_with_scalars("../subst/5.html");
                    }	
	
        );
        if($decl ne ""){
             $decls{$decl}->();
        }elsif($e == 0){
                print content_with_scalars("../subst/impossible.html");
        }
    }elsif($decl ne "exception"){
        print content_with_scalars("../subst/wrong.html");
    }
}