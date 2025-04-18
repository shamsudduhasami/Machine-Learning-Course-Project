
## Load libraries
library(psych)
library(dplyr)

# Define the URL for the processed data file on GitHub.
url <- "https://raw.githubusercontent.com/shamsudduhasami/Machine-Learning-Course-Project/main/2_Project_Processed_Data.csv"

# Read the CSV file directly from the URL
data <- read.csv(url, header = TRUE, stringsAsFactors = FALSE)

# Display the first few rows of the data.
head(data)

## Check the column name and number
data.frame(Column_Number = seq_along(colnames(data)), Column_Name = colnames(data))

## Apply PCA to the standardized columns which are from 33 to 62
# First chose PC1 to check how many PC to choose based on Eigenvalue
pca1 <- principal(data[c(33:62)], nfactors = 1, cor = "cor")
pca1$values

## Using PCA we can specify how many components we want to keep after the analysis.
## But how do we know how many to keep? There is a way to retain only components that have eigenvalues of at least 1. 
## Eigenvalues represent magnitudes of how much variance each component captures in the input data. 
## Thus, larger eigenvalues indicate components that we might want to retain. 
## The rule to use a threshold of ≥1 for eigenvalues to keep is known as the Kaiser Rule or Kaiser Criterion.
sum(pca1$values >= 1)

## Since there are 7 components that have eigenvalue more than 1, I will retain 7 components for this analysis.
pca7 <- principal(data[c(33:62)], nfactors = 7, cor = "cor")
print(pca7)

## Merge the Standardized Loadings to the variables
PCA7_Scores <- bind_cols(data, pca7$scores, id = NULL)

# Save the merged dataset
write.csv(PCA7_Scores, "C:/Users/Sami Shamsudduha/OneDrive - University of Florida/PhD Courseworks/Spring 2025/GLY6932 Machine Learning in Geoscience/Project/3_Project_PCA_Analysis_Data.csv")
