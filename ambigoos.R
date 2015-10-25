library(stringr)

temp <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplenames <- read.table("samplenames",header=FALSE,stringsAsFactors=FALSE,sep="\t")
no_taxa <- dim(samplenames)[1]

rows <- dim(temp)[1]
ambigoo_key <- NULL
i <- 1
j <- 1
proto_struct <- NULL
almost_struct <- NULL

while (i <= rows) {
if ((length(grep("fa*",temp[i,1])))>0) {
ambigootemp <- paste(temp[i,1], j)
ambigoo_key <- rbind(ambigoo_key,ambigootemp)
j <- j + 1
seqlength <- nchar(temp[(i+2),1])
seqpos <- seq(2,(2*no_taxa),2)

tempseq <- unlist(strsplit(temp[(seqpos+i),1],""))
tempstructure <- t(matrix(tempseq,nrow=seqlength,ncol=no_taxa))

As <- colSums(tempstructure=="A")
Cs <- colSums(tempstructure=="C")
Gs <- colSums(tempstructure=="G")
Ts <- colSums(tempstructure=="T")
Ms <- colSums(tempstructure=="M")
Rs <- colSums(tempstructure=="R")
Ws <- colSums(tempstructure=="W")
Ss <- colSums(tempstructure=="S")
Ys <- colSums(tempstructure=="Y")
Ks <- colSums(tempstructure=="K")
Ns <- colSums(tempstructure=="N") + colSums(tempstructure=="-")

ACMs <- which(((As > 0 & Cs > 0) | (As > 0 & Ms > 0) | (Cs > 0 & Ms > 0)) & Gs == 0 & Ts == 0 & Rs == 0 & Ws == 0 & Ss == 0 & Ys == 0 & Ks == 0 & Ns < no_taxa, arr.ind=TRUE)
AGRs <- which(((As > 0 & Gs > 0) | (As > 0 & Rs > 0) | (Gs > 0 & Rs > 0)) & Cs == 0 & Ts == 0 & Ms == 0 & Ws == 0 & Ss == 0 & Ys == 0 & Ks == 0 & Ns < no_taxa, arr.ind=TRUE)
ATWs <- which(((As > 0 & Ts > 0) | (As > 0 & Ws > 0) | (Ts > 0 & Ws > 0)) & Cs == 0 & Gs == 0 & Ms == 0 & Rs == 0 & Ss == 0 & Ys == 0 & Ks == 0 & Ns < no_taxa, arr.ind=TRUE)
CGSs <- which(((Cs > 0 & Gs > 0) | (Cs > 0 & Ss > 0) | (Gs > 0 & Ss > 0)) & As == 0 & Ts == 0 & Rs == 0 & Ws == 0 & Ms == 0 & Ys == 0 & Ks == 0 & Ns < no_taxa, arr.ind=TRUE)
CTYs <- which(((Cs > 0 & Ts > 0) | (Cs > 0 & Ys > 0) | (Ts > 0 & Ys > 0)) & As == 0 & Gs == 0 & Rs == 0 & Ws == 0 & Ms == 0 & Ss == 0 & Ks == 0 & Ns < no_taxa, arr.ind=TRUE)
GTKs <- which(((Gs > 0 & Ts > 0) | (Gs > 0 & Ks > 0) | (Ts > 0 & Ks > 0)) & As == 0 & Cs == 0 & Rs == 0 & Ws == 0 & Ms == 0 & Ss == 0 & Ys == 0 & Ns < no_taxa, arr.ind=TRUE)

sites <- array(c(ACMs,AGRs,ATWs,CGSs,CTYs,GTKs))
sites <- sites[order(sites)]

proto_struct <- rbind((j-1),sites,tempstructure[,sites])
almost_struct <- cbind(almost_struct,proto_struct)

i <- i + 2*(no_taxa) + 1
} else {
i <- i + 1
}
}

write.table(ambigoo_key, "loci_key_ambg_into_struct.txt",quote=FALSE, col.names=FALSE,row.names=FALSE)

fin_struct <- matrix("",ncol=(dim(almost_struct)[2]),nrow=((no_taxa*2)+2))

for (i in 1:no_taxa) {
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="A",arr.ind=TRUE))] <- 1
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="A",arr.ind=TRUE))] <- 1
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="C",arr.ind=TRUE))] <- 2
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="C",arr.ind=TRUE))] <- 2
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="G",arr.ind=TRUE))] <- 3
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="G",arr.ind=TRUE))] <- 3
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="T",arr.ind=TRUE))] <- 4
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="T",arr.ind=TRUE))] <- 4
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="M",arr.ind=TRUE))] <- 1
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="M",arr.ind=TRUE))] <- 2
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="R",arr.ind=TRUE))] <- 1
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="R",arr.ind=TRUE))] <- 3
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="W",arr.ind=TRUE))] <- 1
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="W",arr.ind=TRUE))] <- 4
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="S",arr.ind=TRUE))] <- 2
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="S",arr.ind=TRUE))] <- 3
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="Y",arr.ind=TRUE))] <- 2
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="Y",arr.ind=TRUE))] <- 4
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="K",arr.ind=TRUE))] <- 3
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="K",arr.ind=TRUE))] <- 4
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="N",arr.ind=TRUE))] <- 0
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="N",arr.ind=TRUE))] <- 0
fin_struct[(2*i+1),(which(almost_struct[i+2,]=="-",arr.ind=TRUE))] <- 0
fin_struct[(2*i+2),(which(almost_struct[i+2,]=="-",arr.ind=TRUE))] <- 0
}



