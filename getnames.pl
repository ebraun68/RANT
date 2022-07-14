#!/usr/bin/perl -w

open FH, "<genome_result.txt";
%taxhash = ();

while (<FH>)
{
    if (/^\d+\.\s+(\S[^\n]+)/)
    {
	$tax = $1;
	$tax =~ s/(\S)\s+(\S+)/$1\_$2/g;
	$tax =~ s/\s+//g;
	#	print "$tax\n";
	if (! exists $taxhash{$tax})
	{
	    $taxhash{$tax} = 1;
	}
	else {$taxhash{$tax}++;}
    }
}
close FH;

for $TAX(keys %taxhash)
{
    print "$TAX\t$taxhash{$TAX}\n";
}


    
