library(stringr)

temp <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplenames <- read.table("samplenames",header=FALSE,stringsAsFactors=FALSE,sep="\t")

rows <- dim(temp1)[1]

