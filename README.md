# ambigoos_into_structure v0.1.0 (correcting a pretty big bug!)
Taking fasta alignments with ambiguity codes and turning them into a structure file

# What it does
This set of scripts takes a folder full of fasta files (one per locus, with individuals with mising data padded using Ns - every individual must be present in the files...), and creates a structure file, taking any ambiguity codes in the fasta and writing them out as SNPs. It first aligns the sequences within each locus (each separate fasta file), and then makes sure there is just one sequence per line rather than having the sequence break across multiple lines (onelining.R - note, several of my other repositories have a 'onelining.R' Rscript, but the one in this repository is slightly different, so make sure to grab it and not any of the others!), cats all the fasta files into a giant file called "temp", extracts the sample names, and then finally starts looking for SNPs (ambigoos.R).

# Files it creates
full_SNP_record.txt: This file is a 'quasi' structure file with two heading rows. The first row gives a number representing the locus (key given by loci_key_amb_into_struct.txt), and in the second row the position of the SNP within that locus. All bi-allelic SNPs for each locus that meet your threshold for missing data (see 'How to run it' below) are printed out in this file. This and the other files created by the script use "0" to represent missing data, and have two lines per individual (1 = A, 2 = C, 3 = G, 4 = T).

loci_key_amb_into_struct.txt: The key of what number in the first row of the structure files corresponds to what original name given for the fasta files.

structure_with_double_header.txt: A 'quasi' structure file with two heading rows as for the full_SNP_record.txt. However, this file only contains one SNP per locus (the SNP with the least missing data, or if all SNPs have the same amount of missing data, the first SNP per locus - if you want to use "highest frequency of a minority allele" as the criteria for selecting a SNP, please see the SNP selection criteria section below)

structure.txt: As for the above file, but without the headers i.e. ready to plug straight into structure.

# How to run it
In your folder of fasta alignments for each locus, create a file called proportion which has the proportion of complete data you want i.e. (1 - the amount of missing data you want to allow) e.g.
```
0.8
```
This number should be the only thing in the file. You may want to be fairly permissive with the amount of missing data you allow, because you can rerun downstream parts of the pipeline to "high-grade" for loci present in an ingroup of interest.

Make sure you copy the Rscripts onelining.R and ambigoos.R to your folder as well, and the ambigoos.sh file. Make sure you have installed the stringr package and any dependencies (e.g. stringi, magrittr) in R before running the pipeline. After doing that, you can then run the whole shebang by:

bash ambigoos.sh

# What if you want to tweak the individuals in the file/change completeness of dataset/SNP selection criteria?
It probably makes sense to run the ambigoos pipeline once for all of your samples permitting a lot of missing data, and then focus on subsets of your samples/loci with less missing data, if you don't want to run structure with all the samples included/a lot of msising data. To do that, we are going to use the full_SNP_record.txt file, pull out the samples we don't run, and then run tweaking.R on our modified full_SNP_record.txt. Make sure that you change the value in your proportion file to whatever you would like the completeness of data across your ingroup to be.

If you are coming from stacks, please check out the conversion from stacks step that you need to do before you can run tweaking.R (convert_from_stacks folder within this respository).

First step: grep everything except the samples you don't want e.g.
```
grep -v "kaloula_baleata*" full_SNP_record.txt | grep -v "kaloula_cfbaleata*" | grep -v "kaloula_indo*" | grep -v "kaloula_mediolineata*" | grep -v "kaloula_pulchra*" > mod_full_SNP_record.txt
```
If you are just high-grading for completeness and don't want to exclude any samples then:
```
cp full_SNP_record.txt mod_full_SNP_record.txt
```

Second step:
Instead of taking the first SNP that satisfies your criteria for missing data, you may want to select the SNP at each locus which has the highest minority allele frequency. To do this, add an extra line to your proportion file with YES in upper case e.g.
```
0.8
YES
```

Third step:
```
Rscript tweaking.R
```


# What if you wanted to add a population identifier column after the individual column?
Set up your pop_map file following the instructions at (pop in first column, sample name in the second):
https://github.com/laninsky/phase_everyone_into_migrate#pop-map-designations

Save this file in the same directory as your output structure.txt and/or mod_structure.txt files. The code below is for the structure.txt files - if you want to put the pop labels into your mod_structure.txt files, find and replace 'structure' and replace with 'mod_structure'
```
mv pop_map temp
grep -v '^$' temp > pop_map
rm temp
cp structure.txt structure_popmap.txt

awk '{ print "sed" " " "-i" " " "'\''" "s/" $2 "/" $2 " " $1 "/g" "'\''" " " "structure_popmap.txt"}' pop_map > to_sed.sh

bash to_sed.sh
```
The struture_popmap.txt (or mod_structure_popmap.txt) files will have the population designator inserted in the second column.

#Version history
v0.1.0 The code assumed the order of taxa in each fasta files was the same, which will have led to nonsense results if this was not the case for your data. Sorting on sample name is now included in the onelining.R script in this repository.
v0.0.0 Brand new, may have some bugs

# This pipeline wouldn't be possible without:
MAFFT: http://mafft.cbrc.jp/alignment/software/

R: R Core Team. 2015. R: A language and environment for statistical computing. URL http://www.R-project.org/. R Foundation for Statistical Computing, Vienna, Austria. https://www.r-project.org/

Stringr: Hadley Wickham (2012). stringr: Make it easier to work with strings.. R package version 0.6.2. http://CRAN.R-project.org/package=stringr (for up-to-date citation information run citation("stringr" in R)
