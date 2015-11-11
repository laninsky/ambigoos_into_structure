The output from the stacks into structure pipeline differs a little from the full_SNP_record.txt file output from this pipeline, so we need to get them into the same format before proceeding. This Rscript will take your output from structure and create a file called 'full_SNP_record.txt'. Using this file, you can start at the https://github.com/laninsky/ambigoos_into_structure/blob/master/README.md#what-if-you-want-to-tweak-the-individuals-in-the-filechange-completeness-of-datasetsnp-selection-criteria step.

To run this script, first change the name of your file to temp and then run the Rscript e.g.
```
cp ceyx_60_m5.structure.tsv temp
Rscript convert_from_stacks.R
```
