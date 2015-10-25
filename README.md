# ambigoos_into_structure
Taking fasta alignments with ambiguity codes and turning them into a structure file

# What it does
This set of scripts takes a folder full of fasta files (one per locus), and creates a structure file, taking any ambiguity codes in the fasta and writing them out as SNPs. It first aligns the sequences within each locus (each separate fasta file), and then makes sure there is just one sequence per line rather than having the sequence break across multiple lines (onelining.R - note, several of my other repositories have a 'onelining.R' Rscript, but the one in this repository is slightly different, so make sure to grab it and not any of the others!), cats all the fasta files into a giant file called "temp", extracts the sample names, and then finally starts looking for SNPs (ambigoos.R).

# Files it creates
full_SNP_record.txt: This file is a 'quasi' structure file with two heading rows. The first row gives a number representing the locus (key given by loci_key_amb_into_struct.txt), and in the second row the position of the SNP within that locus. All bi-allelic SNPs for each locus which meets your threshold for missing data (see 'How to run it' below) are printed out in this file. This and the other] files created by the script use "0" to represent missing data, and have two lines per individual (1 = A, 2 = C, 3 = G, 4 = T).

loci_key_amb_into_struct.txt: The key of which number in the first row of the structure files corresponds to what to what original name given for the fasta files.

structure_with_double_header.txt: A 'quasi' structure file with two heading rows as for the full_SNP_record.txt. However, this file only contains one SNP per locus (the SNP with the least missing data, or if all SNPs have the same amount of missing data, the first SNP per locus)

structure.txt: As for the above file, but without the headers i.e. ready to plug straight into structure.

# How to run it
In your folder of fasta alignments for each locus, create a file called proportion which has the proportion of missing data you wish to allow e.g.
```
0.8
```
This number should be the only thing in the file.

Make sure you copy the Rscripts onelining.R and ambigoos.R to your folder as well, and the ambigoos.sh file. You can then run the whole shebang by:

bash ambigoos.sh

#Version history
v0.0.0 Brand new, may have some bugs
