# Comparison of Different Missing Value Imputation (MVI) Techniques

This is a R project for *CSE 5717 - Big Data Analytics* where different **Missing Value Imputation (MVI)** approaches has been compared for three datsets. 

## Data cleanup for Big Data Analytics

* A fundamental challenge for any big data analytics or data mining tasks is to ensure data quality.

* Raw data is often incomplete, inconsistent, and inaccurate - combined with:
1. Noise
2. Outliers
3. Inconsistencies
4. Missing values

* Raw data must be processed and shaped into quality data – requiring preprocessing and cleanup, a crucial step of data mining.

## Missing Values

* Introduces incompleteness in the raw data.
* Different from empty data - 
  * Empty: no value that can be assigned
  * Missing: available values exists but missing in the data

* Many statistical techniques are not robust in analyzing with missing data.
* Often gets challenging to identify the root cause of missingness and produce appropriate actions.
* A key part of data cleanup and data preprocessing before starting the mining process.

# How to deal with Missing Values?

**Strategy 1: Ignoring Missing values**
* Delete data with missing values before mining
* Two strategies of deletion:
  * Listwise deletion: a record is deleted if any of the attribute has missing data in it
  * Pairwise deletion: deletion based on variable of interest
* Several limitations:
  * If missing rate is high, significantly reduces size of the data
  * May affect model strength and lead to inaccurate conclusion
  * Even the rate is small, often small amount of data contribute to valuable information.

**Strategy 2: Missing Value Imputation (MVI)**
* Calculates plausible values based on different strategies and impute missing value with calculated values
* When missing rate is high, deletion is often not a feasible solution
* Leverages information in the observed portion and variability in the data to deal with missing values
* A powerful tool to ensure data quality for mining tasks
* However, can get challenging to select the best possible approach of imputations as several factors are required to be considered as wrong imputation approach can mislead and distort mining results


## Missingness Mechanism

**Why missingness occurred in the dataset?**

* Three mechanisms to explain missingness in the data:
  * Missing Completely At Random (MCAR) - Assumes that the pattern of missingness is completely at random and does not depend on the observed or unobserved portion of data. 
  * Missing At Random (MAR) - Assumes that the pattern of missingness depends on the observed portion of the data and not on the unobserved part of the data.
  * Missing Not At Random (MNAR) - Assumes that probability of missing value depends on unobserved data and external factors that was not considered.

* Helps planning for proper methods and tools to tackle missing value
* Help identifying whether deleting missing data is a viable option


## Missing Rate

* Indicate the ratio of missing value compared to the observed data
* Helps identify the appropriate strategy in dealing with missing values
* If low (5 – 10%), discarding often does not significantly affect the accuracy of mining results.

## MVI Techniques

**Technique 1: Constant Value Imputation**

* Replace missing values with some constant (e.g., global missing flag etc.).

* Works comparatively better for categorical data.

* Disadvantage: Does not consider variability in the data (not “smart”).


**Technique 2: Mean Imputation**

* Replaces the missing values with sample mean of the observed values

* Works better with continuous data that are approximately normally distributed

* Disadvantage: Does not consider correlations across variables

**Technique 3: Median Imputation**

* Replaces the missing values with sample median of the observed values

* Works better when distribution of the missing variable is skewed in nature

* Disadvantage: Same! Does not consider correlations across variables

**Technique 4: Expectation Maximization (EM) Imputation**

* An iterative approach; calculates the likelihood estimates for the incomplete data
* Two steps –
  * *E-Step*: Attempts to estimate the missing data in the variables.
  * *M-Step*: Attempts to optimize the parameters to best explain the data.

* Iteratively alternate between the steps until parameter estimates converge


**Technique 5: k-NN Imputation**
* Uses the k-Nearest Neighbor algorithm to predict the missing data
* Pseudocode:
  1. Start with a suitable value for k – number of nearest neighbors
  2. Compute the similarity of observed data with the missing data using distance functions, e.g., Euclidian distance
  3. Choose the k smallest distance rows as the k nearest neighbor of the missing record
  4. Calculate the weights of the k-nearest values and estimate the missing value as the weighted average of k nearest neighbor

* Disadvantage: Time consuming when the size of the data grows. 
* Disadvantage: Finding the optimal k value is often difficult.

**Technique 6: Multiple Imputation using Chained Equation (MICE)**
* Uses many imputed values to substitute a missing value instead of single imputation
* 3 steps:
  * *Generation*: In an iterative approach, a total of m imputed datasets are created 
  * *Analyze*: m datasets are examined, and parameter of interest is estimated
  * *Combination*: the best result is obtained by combining the m datasets

* Advantage: More unbiased compared to other methods
* Disadvantage: Can be time consuming


## MVI method comparison 

* Comparing five MVI approaches:
  1. Mean Imputation
  2. Median Imputation
  3. EM Imputation
  4. k-NN Imputation
  5. MICE Imputation

* Using three *UCI Machine Learning numeric multivariate datasets* 

* Considering two level of missing rate: *5%* and *55%*

* Evaluating *Normalized Root Mean Square (NRMSE)* as the evaluation metric: lower means better.