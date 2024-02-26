#!/usr/bin/perl -w

open FH, "<EbirdClements.txt";

%idhash = ();
%rankhash = ();
%commonhash = ();
%rangehash = ();
%famhash = ();
%ordhash = ();
%extincthash = ();

open OUT, ">EBnames.txt";
open OUT2, ">Rejects.txt";
while (<FH>)
{
    if (/^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]+)\t([^[\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)/)
    {
	{
	    $eid = $1;
	    $erank = $2;
	    $common = $3;
	    $name = $4;
	    $range = $5;
	    $fam = $6;
	    $ord = $7;
	    $extinct = $8;
#	    print "ok\n";
	    $name =~ s/\s+/\_/g;
	    print OUT "$name\n";
	    $idhash{$name} = $eid;
	    $rankhash{$name} = $erank;
	    $commonhash{$name} = $common;
	    $rangehash{$name} = $range;
	    $famhash{$name} = $fam;
	    $ordhash{$name} = $ord;
	    $extincthash{$name} = $extinct;
	}
    }
    else {print OUT2;}
}
close FH;

open FH2, "<GenBank.AvesSpecies.txt";
while (<FH2>)
{
    if (/^(\S+)\s+(\S+)\s+(\S+)/)
    {
	$gbid = $1;
	$gbname = $2;
	$gbrank = $3;
	if (exists $rankhash{$gbname})
	{
	    print "$gbid\t$gbname\t$gbrank\t$idhash{$gbname}\t$famhash{$gbname}\t$ordhash{$gbname}\t$rankhash{$gbname}\t$commonhash{$gbname}\t$rangehash{$gbname}\t$extincthash{$gbname}";
	}
	else {print "$gbid\t$gbname\t$gbrank\n";}
    }
}
close FH2;
