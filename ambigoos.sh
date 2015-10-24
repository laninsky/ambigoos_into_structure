for i in `ls *.fa*`;
do mv $i tempfile;
mafft tempfile > $i;
echo $i > locinames;
echo $i >> temp;
cat $i >> temp;
done;

grep ">" `cat locinames` > samplenames

Rscript ambigoos.R
