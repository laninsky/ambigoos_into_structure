intable <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")

rows <- dim(intable)[1]

to_write <- intable[1,1]

sequencepaste <- NULL

for (j in 2:rows) {
if ((length(grep(">",intable[j,1])))>0) {
to_write <- rbind(to_write,toupper(sequencepaste))
to_write <- rbind(to_write,intable[j,1])
sequencepaste <- NULL
} else {
sequencepaste <- paste(sequencepaste,intable[j,1],sep="")
}
}

to_write <- rbind(to_write,toupper(sequencepaste))

forsort <- matrix(NA,ncol=2,nrow=((dim(to_write)[1])/2))
forsort[,1] <- to_write[(seq(1,(dim(to_write)[1]),2)),1]
forsort[,2] <- to_write[(seq(2,(dim(to_write)[1]),2)),1]
forsort <- forsort[order(forsort[,1]),]
to_write[(seq(1,(dim(to_write)[1]),2)),1] <- forsort[,1]
to_write[(seq(2,(dim(to_write)[1]),2)),1] <- forsort[,2]

write.table(to_write, "tempout",quote=FALSE, col.names=FALSE,row.names=FALSE)

q()
