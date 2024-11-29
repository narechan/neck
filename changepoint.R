# changepoint.R 
# does changepoint detection
# Invoke % R --slave --args [infile] [penalty_value] < changepoint.R
#	where infile is the bottleneck paint file 

library(changepoint);
set.seed(10);

# retrieve the args
Args<-commandArgs();

# change point analysis
m.data <- read.table(Args[4]);
cp.data <- m.data$V3;

# Conditional behavior for penalty
if (Args[5] == "BIC") {
  # Use BIC penalty
  cp.result <- cpt.mean(cp.data, method = "PELT", penalty = "BIC", pen.value = "default")
} else {
  # Use manual penalty
  manual_penalty <- as.numeric(Args[5]) # Convert input to numeric
  cp.result <- cpt.mean(cp.data, method = "PELT", penalty = "Manual", pen.value = manual_penalty)
}

# Print results
cat(cpts(cp.result));
