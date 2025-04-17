# Machine-Learning-Course-Project
The documents, code, figures, etc. uploaded here is produced for the course project only


**Developing a County Level Social Vulnerability Index (SoVI) for the Contiguous United States**

To develop the Social Vulnerability Index (SoVI), I downloaded a broad set of demographic and socioeconomic variables from the U.S. Census Bureau (https://data.census.gov/). Then these variables are normalized as either percentage, per capita values, or density functions. I standardized every variable to a z‐score (mean = 0, standard deviation = 1) (Eq. below). This ensures that variables measured on different scales contribute equally to the downstream analysis. 

z=  (x- μ)/σ

These dataprocessing is done in the google colab. The code is provided in this repository (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/Project_Machine_Learning_Course.ipynb). Then I saved the processed data also uploded in the repository (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/2_Project_Processed_Data.csv) for the use of PCA in RStudio.

I performed a principal components analysis (PCA) in RStudio on these standardized variables from the 2_Project_Processed_Data.csv dataset, using a varimax rotation to sharpen the definition of each component and applying the Kaiser criterion (eigenvalues > 1) to determine the appropriate number of factors. Then I saved the PCA analysis result uploaded in this repository (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/3_Project_PCA_Analysis_Data.csv).

After that I loaded the 3_Project_PCA_Analysis_Data.csv in the following colab code. Then I examined the factor loadings by looking at the correlations between each input variable and the extracted components to interpret the underlying dimensions of social vulnerability. Variables loading strongly (absolute value > 0.60) on a component guided its labeling (for example, a “Wealth & Economic Status” factor for 5 variables in the table).
Because some factors inherently reflect decreased vulnerability (such as higher wealth) while others reflect increased vulnerability (such as greater poverty), I applied a directional adjustment (cardinality) to each component. In practice, this meant multiplying “protective” factors by -1 so that higher scores on every adjusted component uniformly indicate greater vulnerability. I exported these adjusted component scores for each census tract to a separate file named 3_Project_PCA_Analysis_Data.csv also uploaded in the GitHub repository.

Finally, I aggregated the component scores in a simple additive model, summing each cardinality‐adjusted factor to compute a single SoVI score per tract and saved the data uploaded in the repository (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/4_Project_PCA_Analysis_Processed.xlsx) to use in ArcGIS Pro to make the vulnerability analysis. To visualize spatial patterns of vulnerability, I mapped these SoVI scores in ArcGIS Pro using a quantile classification, highlighting areas of very low, low, medium, high, and very high social vulnerability. This narrative methodology transforms complex, multi‐dimensional census data into an intuitive index that decision makers can use to identify and compare vulnerable communities.
