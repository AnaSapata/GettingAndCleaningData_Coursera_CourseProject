## GettingAndCleaningData_Coursera_CourseProject

The script start to download the zip file. After that I unzip the same manually. 

It is loaded the test sets (*X_test*, *y_test*, *subject_test*), and then the train sets (*X_training*, *y_trainig*, *subject_train*). To merge all the test sets it was used the **cbind**, to put all the columns together, the same was made for the train sets.

Since the test and train sets has the same structure(all variables in the same order) was used the **rbind** to merge the two data sets. Since the data is now all together the next step was attribute the names to the variables(columns). Their names are in the file *features.txt*, which was readed with the function **read.table**.

The second column of the previous data frame was assigned to the columns names which index was between 2 and 562, and the first variable take the name *"Subject"* and the last *"Activity"*.

Following that, searched for the columns referents to the mean and standard deviation, throught the **grep** function using the patterns *"-mean()"* and *"-std()"*, getting the respective column index. The index was combined in a vector and was obtained a subset by this index, plus the 1 and 563. Now, I has a data frame with the subject, the variables corresponding to the mean and standard deviation, and the activity.

Since the activity is code by the numbers 1-6, I read the file *activity_labels.txt* to decode this. Was made a merge throught the previous data frame and the activity data frame, by the columns with the numbers, after that, was deleted the column with the code of the activity and rename the columns with the descriptive activity to *"Activity"*.

Once in the tidy data just was need the mean values, was made again the grep with the pattern *"-mean()"* to get the index of the columns that corresponding to the mean. After, was obtained a subset from the data frame, to have just the columns *Subject*, *Activity* and the corresponding to the mean.

Was used the **gather** function to transform the data in tidy data, and also used the function **separate** to obtain the *variable*, *measure* and *axis*, from the previous variable that contain all this three together. Since the *measure* is always mean and the last column that contais the values is also called *mean*, the *measure* column was deleted. 

#### Now I get the tidy data that was expect :D