# Getting-and-Cleaning-Data-Course-Project
This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset and extract to the working directory
2. Load both training and text datasets using fread and merge them.
3. Read features file, which contains all the column names and assign it to the merged data file
4. Read the activity file and use the second column names as label to the activity column values in mereged data file
5. Select the columns which contains text activity, subject, mean, and std from merged files.
6. Use dplyr to average the measurments by subject and activity.
7. Write the preprocessed tidy data into tidy_smartphone_data.txt file.

##Dependencies

The run_analysis.R file requires 2 packages data.table and dplyr. The data.table is used to speed up the reading process from the files. Using read.table instead of fread can avoid the dependency on data.table.


