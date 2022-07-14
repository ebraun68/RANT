#!/usr/bin/perl -w

open FH, "<taxonomy_result.unix.xml";

while (<FH>)
{
    if (/^<Taxon>/)
    {
	$numid = 0;
	$numname = 0;
	$numrank = 0;
	
    }
    elsif (/\s+<TaxId>([^\<]+)</)
    {
	$temp1 = $1;
	$numid++;
	if ($numid == 1)
	{
	    $taxid = $temp1;
	}
    }
    elsif (/^\s+<ScientificName>([^\<]+)</)
    {
	$temp2 = $1;
	$numname++;
	if ($numname == 1)
	{
	    $sciname = $temp2;
	    $sciname =~ s/\s+/\_/g;
	}
    }
    elsif (/^\s+<Rank>([^\<]+)\</)
    {
	$temp3 = $1;
	$numrank++;
	if (($numrank == 1) && ($temp3 =~ m/species/))
	{
	    $rank = $temp3;
	    print "$taxid\t$sciname\t$rank\n";
	}
    }
}
