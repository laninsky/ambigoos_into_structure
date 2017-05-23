These scripts get pre-existing structure files in to the full_SNP_record.txt format. Using this file, you can start at the https://github.com/laninsky/ambigoos_into_structure/blob/master/README.md#what-if-you-want-to-tweak-the-individuals-in-the-filechange-completeness-of-datasetsnp-selection-criteria step.

This conversion step assumes you have a column of population IDs following the sample names, a header row with the locus ID (multiple SNPs per locus are allowed), and SNP encoding as 1-4 (A,C,G,T) and missing as 0. If your structure file doesn't look like this, check out the utilities at: https://github.com/laninsky/creating_dadi_SNP_input_from_structure

To run this script, first change the name of your file to temp and then run the Rscript e.g.
```
cp ceyx_60_m5.structure.tsv temp
Rscript convert_from_stacks.R
```
