library(stringr)

temp <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplenames <- read.table("samplenames",header=FALSE,stringsAsFactors=FALSE,sep="\t")
no_taxa <- dim(samplenames)[1]

rows <- dim(temp)[1]
ambigoo_key <- NULL
i <- 1
j <- 1
proto_structure_file <- NULL

while (i <= rows) {
if ((length(grep("fa*",temp[i,1])))>0) {
ambigootemp <- paste(temp[i,1], j)
ambigoo_key <- rbind(ambigoo_key,ambigootemp)
j <- j + 1
seqlength <- nchar(temp[(i+2),1])
seqpos <- seq(2,(2*no_taxa),2)

tempseq <- unlist(strsplit(temp[(seqpos+1),1],""))
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

sites <- c(ACMs,AGRs,ATWs,CGSs,CTYs,GTKs)





i <- i + 2*(no_taxa) + 1
} else {
i <- i + 1
}
}
