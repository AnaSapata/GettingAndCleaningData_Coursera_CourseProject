# ------------------------------------------------------------------------------------------------------------------------------- #
#                                                                                                                                 #
#                                     Getting and Cleaning Data - Coursera - Course Project                                       #
#                                                         30/Ago/2019                                                             #
#                                               Ana Sapata (ana_sapata@sapo.pt)                                                   #
#                                                                                                                                 #
# ------------------------------------------------------------------------------------------------------------------------------- #


# Download the zip
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              '/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/Dataset.zip')

# Load the test sets
x_test <- read.table('/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/test/subject_test.txt')

# Merge of all datasets related with test set
test <- cbind(subject_test, x_test, y_test)

# Load the train sets
x_train <- read.table('/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/train/X_train.txt')
y_train <- read.table('/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/train/y_train.txt')
subject_train <- read.table('/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/train/subject_train.txt')

# Merge of all datasets related with train set
train <- cbind(subject_train, x_train, y_train)

# Merge the data from train set and test set
all_data <- rbind(train, test)

# load the file with the features names
features <- read.table('/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/features.txt',
                       stringsAsFactors = FALSE)

# Attribute the names of features in the previous file to the columns of the data frame with all the data
colnames(all_data) <- c("Subject", features[,2], "Activity")

# Get the index of columns with "-mean()" in the name
mean_index <- grep("-mean()", colnames(all_data))

# Get the index of columns with "-std()" in the name
std_index <- grep("-std()", colnames(all_data))

# From all data just get the variables Subject, Activity and all related with mean and std
index_columns <- c(1, mean_index, std_index, 563)
final_data <- all_data[,sort(index_columns)]

# Load the file with the activities name
activities <- read.table('/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/activity_labels.txt',
                         stringsAsFactors = FALSE)

# Merge of data sets final_data and activities
final_data_w_act <- merge(final_data, activities, by.x = "Activity", by.y = "V1")
# Remove the variable activity since is integer type
final_data_w_act$Activity <- NULL
# Rename the columns, so V2 become Activity
colnames(final_data_w_act) <- c(colnames(final_data_w_act[,-81]), "Activity")
# Get the index of columns with "-mean()" in the name
mean_index_2 <- grep("-mean()", colnames(final_data_w_act))
# Just the mean data
final_data_w_act_mean <- final_data_w_act[, c(1, mean_index_2, 81)]

library(tidyr)
# Get the data in tidy form
tidy_data <- gather(final_data_w_act_mean, variable, mean, -Activity, -Subject)
# Separate the variable with the name "variable" into variable, measure and axis
tidy_data <- separate(data = tidy_data, col = variable, into = c("variable", "measure", "axis"))
# Delete the variable measure, since is repeate
tidy_data$measure <- NULL

write.csv(tidy_data, '/home/anasapata/Personal/datasciencecoursera/Getting and Cleaning Data/Week4/GettingAndCleaningData_Coursera_CourseProject/tidy_data.csv',
          row.names = FALSE)
