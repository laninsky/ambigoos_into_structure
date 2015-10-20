for i in `ls *.fa*`;
do echo $i > locinames;
echo $i >> temp;
cat $i >> temp;
done;

Rscript ambigoos.R
