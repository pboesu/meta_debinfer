#!/bin/bash
Rscript --vanilla timings_master_tj.R 10 tidier-joints debinfer
Rscript --vanilla timings_master_tj.R 10 master debinfer
Rscript --vanilla timings_master_tj.R 10 master logistic
Rscript --vanilla timings_master_tj.R 10 tidier-joints logistic


