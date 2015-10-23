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



