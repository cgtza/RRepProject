This repo contains 

1) a data file, which is a modified version of that collected by Reyes-Ortiz et al., and as located at 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

2) an R script for transforming the original data so that the dataset contains one subject per row, and each field is then
the mean for each of the variables Reyes-Ortiz et al. collected WHERE they computed the mean and standard deviation
for the variable.  Other variables are dropped by the script

3) in order to run the script, you need to 

a) ensure that the original data file is located from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip, 
unzipped, and then all the txt files in the original data archive should be located in your R working directory

b) then run the script by loading it into R and executing it

c) note that this will save a file to your working directory that will be called Activity_data_per_activity_and_subject.txt