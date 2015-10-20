for i in `ls *.fa*`;
do echo $i >> temp;
cat $i >> temp;
done;

Rscript ambigoos.R
