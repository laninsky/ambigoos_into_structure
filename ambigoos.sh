for i in `ls *.fa*`;
do mafft $i > temp;
Rscript onelining.R;
mv tempout $i;
done;

rm tempout

for i in `ls *.fa*`;
do echo $i > locinames;
echo $i >> temp;
cat $i >> temp;
done;

grep ">" `cat locinames` > samplenames

Rscript ambigoos.R
