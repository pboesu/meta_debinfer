#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

  
# test if there is at least one argument: if not, return an error
  if (length(args)!=3) {
    stop("Three arguments must be supplied (reps, ref, tests)", call.=FALSE)
  }

reps = as.numeric(args[1])
ref = args[2]
tests = args[3]

library(devtools)
library(testthat)

#define some helper functions
library(plyr)
test_time_summary_sg <- function(x){
  plyr::ldply(x, function(x) data.frame(test = x$test, user = x$user, system = x$system, real = x$real))
}

test_time_summary <- function(x){
  plyr::ddply(plyr::ldply(x, test_time_summary_sg), ~ test, summarize, min_real = min(real), med_real = median(real), max_real = max(real))
}

#master
install_github("pboesu/debinfer", ref=ref)
library(deBInfer)
out <- lapply(seq_len(reps), function(x) test_package("deBInfer",filter = tests))
saveRDS(out, paste(ref,"-",tests,"-",Sys.info()["sysname"],".RDS", sep = ""))
test_time_summary(out)
detach("package:deBInfer", unload=TRUE)
remove.packages("deBInfer")


