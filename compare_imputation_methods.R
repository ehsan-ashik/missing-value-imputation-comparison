install.packages('missForest')
install.packages("mice")
install.packages("VIM")
install.packages("hydroGOF")
install.packages("mvdalab")
install.packages("caret") 
install.packages("laeken") 

library(missForest)
library(mice)
library(VIM)
library(hydroGOF)
library(mvdalab)
library(caret)
library(dplyr)
library(laeken)


# datasets
wine_dataset_id <- "wine.data.csv"
liverpatient_dataset_id <- "liverpatient.data.csv"
glass_dataset_id <- "glass.data.csv"


# import dataset and see summary stats

df <- read.csv(file = liverpatient_dataset_id, sep = ",", header = FALSE)
summary(df)

df <- na.omit(df) 
df.mean<-sapply(df,FUN=mean)
mean(df.mean)

COLUMNS <- ncol(df)
COLUMNS

## Introduce missing values 
missingRates <- list(0.05, 0.55)

df.mis <- prodNA(df, missingRates[[2]])
summary(df.mis)



# plot of missing data
mice_plot <- aggr(df.mis, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(df.mis), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))


#impute data using MICE
m <- 5
max_iterations <- 50
seed <- 42

imputed.mice <- mice(df.mis, m=m, maxit=max_iterations, method='pmm', seed=seed)

nrmses <- rep(NA, m)
for (i in seq_len(m)) {
  fill <- complete(imputed.mice, i)
  nrmses[i] <- mean(nrmse(fill, df, na.rm=TRUE, norm="maxmin"))
}

nrmses
nrmse_mice_pmm <- min(nrmses)



#EM Imputation
max_iterations <- 50

imputed_em <- imputeEM(df.mis, iters=max_iterations)

nrmse_em <- mean((nrmse(imputed_em$Imputed.DataFrames[[1]], df, na.rm=TRUE, norm="maxmin")))



# kNN Impute
ks <- list(2, 5, 10)
nrmses <- rep(NA, length(ks))

for (i in 1:length(ks)) {
  temp <- kNN(df.mis, numFun=weightedMean, weightDist=TRUE, k=ks[[i]], impNA = TRUE)
  imputed_knn <- data.frame(temp[,(1:COLUMNS)])
  
  nrmses[i] <- mean(nrmse(imputed_knn, df, na.rm=TRUE, norm="maxmin"))
}

nrmses
nrmse_knn <- min(nrmses)



# mean imputation
temp = df.mis

for(i in 1:ncol(df.mis)) {
  temp[ , i][is.na(df.mis[ , i])] <- mean(df.mis[ , i], na.rm = TRUE)
}

nrmse_mean <- mean(nrmse(temp, df, na.rm=TRUE, norm="maxmin"))



#median imputation
temp = df.mis

for(i in 1:ncol(df.mis)) {
  temp[ , i][is.na(df.mis[ , i])] <- median(df.mis[ , i], na.rm = TRUE)
}

nrmse_median <- mean(nrmse(temp, df, na.rm=TRUE, norm="maxmin"))


nrmse_mice_pmm 
nrmse_em 
nrmse_knn 
nrmse_mean 
nrmse_median
