# Invoke % R --slave --args [infile] [outfile] < mds.R

# retrieve the args
Args<-commandArgs();

library(bcp);
df <- read.table(Args[4]);
dfv <-as.vector(df$V4);
plot(dfv);
bcp_x <- bcp(dfv, return.mcmc = TRUE);
plot(bcp_x);
frame <- data.frame(df$V1, df$V2, df$V3, bcp_x$posterior.prob);
write.table(frame, file = Args[5], sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE);
