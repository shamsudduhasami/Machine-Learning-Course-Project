# Machine-Learning-Course-Project
The documents, code, figures, etc. uploaded here is produced for the course project only


**Developing a County Level Social Vulnerability Index (SoVI) for the Contiguous United States**

To develop the Social Vulnerability Index (SoVI), I downloaded a broad set of demographic and socioeconomic variables from the U.S. Census Bureau (https://data.census.gov/). Then these variables are normalized as either percentage, per capita values, or density functions. I standardized every variable to a z‐score (mean = 0, standard deviation = 1) (Eq. below). This ensures that variables measured on different scales contribute equally to the downstream analysis. 

z=  (x- μ)/σ

These dataprocessing is done in the google colab. The code is provided in this repository (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/Project_Machine_Learning_Course.ipynb). Then I saved the processed data also uploded in the repository (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/2_Project_Processed_Data.csv) for the use of PCA in RStudio.

I performed a principal components analysis (PCA) in RStudio (code link https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/PCA%20Analysis%20Part%20in%20RStudio.R) on these standardized variables from the 2_Project_Processed_Data.csv dataset, using a varimax rotation to sharpen the definition of each component and applying the Kaiser criterion (eigenvalues > 1) to determine the appropriate number of factors. Then I saved the PCA analysis result uploaded in this repository (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/3_Project_PCA_Analysis_Data.csv).

After that I loaded the 3_Project_PCA_Analysis_Data.csv in the following colab code. Then I examined the factor loadings by looking at the correlations between each input variable (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/Heatmap%20of%20PCA%20Loadings.png).

![Heatmap of PCA Loadings](https://github.com/user-attachments/assets/6caf1b80-4d8c-445c-8719-e474d928e9e2)

I extracted components to interpret the underlying dimensions of social vulnerability. Variables loading strongly (absolute value > 0.60) on a component guided its labeling (for example, a “Wealth & Economic Status” factor for 5 variables in the table).

![PCA Table](https://github.com/user-attachments/assets/184404b8-4495-4697-ac90-dc71afbc0597)


Because some factors inherently reflect decreased vulnerability (such as higher wealth) while others reflect increased vulnerability (such as greater poverty), I applied a directional adjustment (cardinality) to each component. In practice, this meant multiplying “protective” factors by -1 so that higher scores on every adjusted component uniformly indicate greater vulnerability. I exported these adjusted component scores for each census tract to a separate file named 3_Project_PCA_Analysis_Data.csv also uploaded in the GitHub repository.

Finally, I aggregated the component scores in a simple additive model, summing each cardinality‐adjusted factor to compute a single SoVI score per tract and saved the data uploaded in the repository (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/4_Project_PCA_Analysis_Processed.xlsx) to use in ArcGIS Pro to make the vulnerability analysis. To visualize spatial patterns of vulnerability, I mapped these SoVI scores (https://github.com/shamsudduhasami/Machine-Learning-Course-Project/blob/main/SoVI%20Map.jpg) in ArcGIS Pro using a quantile classification, highlighting areas of very low, low, medium, high, and very high social vulnerability. This narrative methodology transforms complex, multi‐dimensional census data into an intuitive index that decision makers can use to identify and compare vulnerable communities.

![SoVI Map](https://github.com/user-attachments/assets/406428f0-665b-4761-999e-1f5705eb3470)

After calculating the Social Vulnerability Index (SoVI) scores for all counties, I conducted spatial autocorrelation analyses in ArcGIS Pro to examine clustering patterns in Texas. This two-step approach involved an Incremental Spatial Autocorrelation (ISA) using Global Moran’s I, followed by a Local Moran’s I (Anselin) cluster and outlier analysis at the optimal distance. Applying these spatial analyses to the SoVI results is important for determining whether high or low vulnerability counties tend to cluster together beyond random chance. Identifying significant clusters of social vulnerability can highlight areas that may require targeted policy attention or resources, and Texas was selected for focused analysis because prior studies have indicated the presence of pronounced vulnerability clusters in this state​. Texas’s large size and socio-demographic diversity, as well as its frequent exposure to natural hazards, make it an ideal case for investigating spatial patterns of social vulnerability.

**Incremental Spatial Autocorrelation (Global Moran’s I)**

To determine the scale at which SoVI values exhibit the strongest spatial clustering, I performed an incremental spatial autocorrelation analysis using Global Moran’s I. This tool evaluates spatial autocorrelation (clustering or dispersion) over a range of distances. I specified a fixed number of 30 distance bands, starting at 150,000 meters and increasing in 10,000-meter increments (Euclidean distance with row-standardized weights). At each distance band, Moran’s I and its corresponding z-score were computed to measure the intensity of spatial clustering of county SoVI values. In line with theoretical expectations, the Global Moran’s I z-scores increased with distance initially, indicating intensification of spatial clustering, and then reached a distinct peak before declining. The figure below illustrates the resulting z-scores as a function of distance.

![Spatial_Autocorrelation using Increment](https://github.com/user-attachments/assets/ae44cab4-e6cb-4203-a0a5-5f6d813329f5)

The analysis identified a clear maximum z-score at the 300,000-meter distance band, where the z-score reaches approximately 17.3 (p < 0.0001), after which the z-scores plateau or decrease slightly.
