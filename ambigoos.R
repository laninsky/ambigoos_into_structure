library(stringr)

temp <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplenames <- read.table("samplenames",header=FALSE,stringsAsFactors=FALSE,sep="\t")
no_taxa <- dim(samplenames)[1]

rows <- dim(temp)[1]
ambigoo_key <- NULL
j <- 1
proto_structure_file <- NULL

while (i <= rows) {
if ((length(grep("fa*",temp[i,1])))>0) {
ambigootemp <- paste(temp[i,1], j)
ambigoo_key <- rbind(ambigoo_key,ambigootemp)
j <- j + 1
seqlength <- nchar(temp[(i+2),1])
seqpos <- seq(2,(2*no_taxa),2)

tempstructure <- matrix(NA,nrow=no_taxa,ncol=seqlength) 

for (k in 1:(length(seqpos))) {
tempstructure[k,] <- unlist(strsplit(temp[(seqpos[k]+1),1],""))
}




tempstructure[1:no_taxa,1] <- samplenames[1:no_taxa,1]



i <- i + 2*(no_taxa) + 1
} else {
i <- i + 1
}
}
