library(stringr)

temp <- read.table("mod_full_SNP_record.txt",header=FALSE,stringsAsFactors=FALSE,sep=" ")
no_taxa <- (dim(temp)[1]-2)/2
prop <- read.table("proportion",header=FALSE,stringsAsFactors=FALSE,sep="\t")

zeroes <- array(c(which(((colSums(temp[3:(dim(temp)[1]),]==0)/(no_taxa*2))<=(1-prop[1,1])),arr.ind=TRUE)))
SNPs_complete_enough <- temp[,zeroes]
rm(temp)

As <- colSums(SNPs_complete_enough[3:(dim(SNPs_complete_enough)[1]),]=="1")
Cs <- colSums(SNPs_complete_enough[3:(dim(SNPs_complete_enough)[1]),]=="2")
Gs <- colSums(SNPs_complete_enough[3:(dim(SNPs_complete_enough)[1]),]=="3")
Ts <- colSums(SNPs_complete_enough[3:(dim(SNPs_complete_enough)[1]),]=="4")
Ns <- colSums(SNPs_complete_enough[3:(dim(SNPs_complete_enough)[1]),]=="0")

ACMs <- which(((As > 0 & Cs > 0) & Gs == 0 & Ts == 0), arr.ind=TRUE)
AGRs <- which(((As > 0 & Gs > 0) & Cs == 0 & Ts == 0), arr.ind=TRUE) 
ATWs <- which(((As > 0 & Ts > 0) & Cs == 0 & Gs == 0), arr.ind=TRUE) 
CGSs <- which(((Cs > 0 & Gs > 0) & As == 0 & Ts == 0), arr.ind=TRUE) 
CTYs <- which(((Cs > 0 & Ts > 0) & As == 0 & Gs == 0), arr.ind=TRUE) 
GTKs <- which(((Gs > 0 & Ts > 0) & As == 0 & Cs == 0), arr.ind=TRUE) 

sites <- array(c(ACMs,AGRs,ATWs,CGSs,CTYs,GTKs))
sites <- sites[order(sites)]
proto_high_grade <- as.matrix(SNPs_complete_enough[,sites])

loci <- unique(proto_high_grade[1,])
noloci <- length(loci)
high_grade <- SNPs_complete_enough[,1]
rm(SNPs_complete_enough)

for (j in 1:(noloci)) {
temp_high_grade <- (proto_high_grade[,(proto_high_grade[1,]==loci[j])])
if (is.vector(temp_high_grade)) {
temp_high_grade <- matrix(temp_high_grade)
high_grade <- cbind(high_grade,temp_high_grade)
} else {
if(is.na(prop[2,1])) {
high_grade <- cbind(high_grade,temp_high_grade[,(which.min(t(matrix(colSums(temp_high_grade[3:(no_taxa*2+2),(temp_high_grade[1,]==loci[j])]==0)))))])
} else {
minmaj <- matrix(0,ncol=(dim(temp_high_grade)[2]),nrow=4)
minmaj[1,] <- colSums(temp_high_grade[3:(dim(temp_high_grade)[1]),]==1)
minmaj[2,] <- colSums(temp_high_grade[3:(dim(temp_high_grade)[1]),]==2)
minmaj[3,] <- colSums(temp_high_grade[3:(dim(temp_high_grade)[1]),]==3)
minmaj[4,] <- colSums(temp_high_grade[3:(dim(temp_high_grade)[1]),]==4)

highmin <- matrix(0, ncol=(dim(temp_high_grade)[2]),nrow=1)
for (i in 1:(dim(temp_high_grade)[2])) {
highmin[i] <-(minmaj[(max.col(t(minmaj))[i]),i])/(sum(minmaj[1:4,i]))
}

high_grade <- cbind(high_grade,temp_high_grade[,(which.min(highmin))])
}
}
}

final_structure <- high_grade[3:(no_taxa*2+2),]

write.table(high_grade, "mod_structure_with_double_header.txt",quote=FALSE, col.names=FALSE,row.names=FALSE)
write.table(final_structure, "mod_structure.txt",quote=FALSE, col.names=FALSE,row.names=FALSE)

print("mod_structure.txt has the following number of taxa:")
print(no_taxa)
print("mod_structure.txt has the following number of loci:")
print(noloci)
