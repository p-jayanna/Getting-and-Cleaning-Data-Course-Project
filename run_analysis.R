#Libraries for reading and tidying the data sets
library(data.table)
library(dplyr)

#Read the training and text files using fread.
subject_train <- read.table("~/Coursera/Week4/UCI HAR Dataset/train/subject_train.txt")
X_train <- fread("~/Coursera/Week4/UCI HAR Dataset/train/X_train.txt")
Y_train <- fread("~/Coursera/Week4/UCI HAR Dataset/train/y_train.txt" )

subject_test <- read.table("~/Coursera/Week4/UCI HAR Dataset/test/subject_test.txt")
X_test <- fread("~/Coursera/Week4/UCI HAR Dataset/test/X_test.txt")
Y_test <- fread("~/Coursera/Week4/UCI HAR Dataset/test/y_test.txt" )

#merge the training and testing data sets using cbind and rbind to create one dataset
smartphone_data <- rbind(cbind(subject_train, Y_train, X_train), cbind(subject_test, Y_test, X_test))

# read name the columns from features text file  and add 2 columns(subject and activity) which are not availble in text file.
col_names_smarphone_data <- fread("~/Coursera/Week4/UCI HAR Dataset/features.txt")
col_names_smarphone_data <- rbind(data.frame(V1 = 1, V2 = "activity"), col_names_smarphone_data) 
col_names_smarphone_data <- rbind(data.frame(V1 = 2, V2 = "subject"), col_names_smarphone_data) 
names(smartphone_data) <- col_names_smarphone_data[[2]]

#Extracting only the measurements on the mean and standard deviation.
col_names_smarphone_data <- grepl("subject|activity|mean|std", colnames(smartphone_data))

#select only mean and standard deviation columns from smartphone_data
smartphone_data <- smartphone_data[, col_names_smarphone_data]
  

#read activity labels from filee and assign to the smartphone_data.
activity_labels <- fread("~/Coursera/Week4/UCI HAR Dataset/activity_labels.txt")
smartphone_data$activity <-  factor(smartphone_data$activity,  levels = activity_labels$V1, labels = activity_labels$V2)

# group by subject and activity and summarise using mean
smartphone_data <- smartphone_data %>% 
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# output to file "tidy_data.txt"
write.table(smartphone_data, "tidy_smartphone_data.txt", row.names = FALSE, 
            quote = FALSE)
