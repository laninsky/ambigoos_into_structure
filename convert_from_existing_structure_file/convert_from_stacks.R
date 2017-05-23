temp <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")

depth <- dim(temp)[1]

temp1 <- temp[1:depth,-2]
rm(temp)
width <- dim(temp1)[2]

placeholder <- c("",seq(1,width,1))

headers <- rbind(temp1[1,],placeholder)

output <- rbind(headers,temp1[2:depth,])

write.table(output, "full_SNP_record.txt",quote=FALSE, col.names=FALSE,row.names=FALSE)
