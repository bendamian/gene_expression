# script to manipulate gene expression data

# load libraries
library(dplyr)
library(tidyverse)
library(ggplot2)
#library(GEOquery)


# Select a data file
filename <-'/home/damian/Desktop/R/newtest/sample.txt'

# read in the data 
data_man <- read.table(filename, sep="\t", quote="", stringsAsFactors=FALSE,header=TRUE)
dim(my_data)

# select, data ------------
data_man.subset <-select(data_man, c(1,2,2,4,5))

# Make the heatmap data into a matrix
matrix_two <- as.matrix(data_man.subset[c(1:10) ,])# [ten rows, columns 4]

# reshaping data - from wide to long-
data_long <- gather(data_man, key = "samples", value = "FPKM", -Gene)
dtaa_long.subset <-data_long[c(1:25),]

# Assuming data_long is your data frame with the FPKM column
data_long <- data_long %>%
  mutate(status = ifelse(FPKM > 5, "positive", "negative"))