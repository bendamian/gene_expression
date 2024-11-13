#if (!requireNamespace("BiocManager", quietly=TRUE))
   #install.packages("BiocManager")
#BiocManager::install("InteractiveComplexHeatmap")


library(tidyverse)
library(dplyr)
library(ComplexHeatmap)
#library(InteractiveComplexHeatmap)
library(circlize)
# Select a data file
filename <-'/home/damian/Desktop/R/newtest/sample.txt'

# Read the data into a data.frame
my_data <- read.table(filename, sep="\t", quote="", stringsAsFactors=FALSE,header=TRUE,row.names=1)

myhead(my_data)

dim(my_data) # (rows columns)

nrow(my_data) # rows: locations (bins) in genome
ncol(my_data) # columns: cells

# Make the heatmap data into a matrix
my_matrix <- as.matrix(my_data[c(1:25)  ,c(2:25)]) # [all rows, columns 2-25]
# leave out the first 3 columns (chrom,start,end) since they don't belong in the heatmap itself

# We can check the classes:
class(my_data)
class(my_matrix)

head(my_matrix)

# Save gene column for annotating the heatmap later
gene_info <- data.frame(Gene = my_data$Gene)
gene_info

## Now we make our first heatmap 

# Default parameters
Heatmap(my_matrix)


# Flip rows and columns around
my_matrix <- t(my_matrix)  # "transpose"
Heatmap(my_matrix)


# Keep genome bins in order, not clustered
Heatmap(my_matrix, cluster_columns=FALSE)

fontsize <- 0.6

# Put cell labels on the left side
Heatmap(my_matrix, cluster_columns=TRUE,
        row_names_side = "left", 
        show_row_dend = TRUE,
        row_names_gp=gpar(cex=fontsize))

# Make the dendrogram wider
Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        show_row_dend = TRUE,
        row_names_gp=gpar(cex=fontsize),
        row_dend_width = unit(3, "cm"))

# Check the range of values in the data matrix
range(my_matrix, na.rm = TRUE)

# Define the new color function based on the actual range of data
# Assuming the range from the above check is [0, 10], you can modify it like this:
col_fun = colorRamp2(c(0, 5, 10), c("white", "blue", "red"))

# Create the heatmap with the adjusted color scale
ht = Heatmap(my_matrix, 
            name = 'Sample2',
            cluster_columns=TRUE,
            col = col_fun, 
            row_names_side = "left", 
            show_row_dend = TRUE,
            show_column_names = TRUE,
            row_names_gp=gpar(cex=fontsize),
            row_dend_width = unit(3, "cm"))

ht = draw(ht) # not necessary, but recommended


my_data %>%
  filter(gene)




