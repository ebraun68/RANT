#!/usr/bin/perl -w

open FH, "<taxonomy_result.txt";
%tidhash = ();
open OUT, ">aves2.nucl_gb.accession2taxid";

while (<FH>)
{
    if (/^(\d+)/)
    {
	$tid = $1;
	if (! exists $tidhash{$tid})
	{
	    $tidhash{$tid} = 0;
	}
    }
}
close FH;

open FH2, "<nucl_gb.accession2taxid";
while (<FH2>)
{
    if (/^\S+\s+\S+\s+(\d+)/)
    {
	$TID = $1;
	if (exists $tidhash{$TID})
	{
	    $tidhash{$TID}++;
	    print OUT;
	}
    }
}
close FH2;

$total = 0;
for $Tid(keys %tidhash)
{
    print "$Tid\t$tidhash{$Tid}\n";
    $total = $total + $tidhash{$Tid};
}
print "Total = $total\n";

	
