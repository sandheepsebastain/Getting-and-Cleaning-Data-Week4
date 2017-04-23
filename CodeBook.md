#Code Book
##Getting and Cleaning Data Week 4

The script run_analysis.R transforms the Human Activity Recognition Using Smartphones Data Set from UCI Machine Learning Repository into a clean and useable dataset and finally outputs a dataset that contains the average values of each variable per subject per activity type.

The data required ie the Human Activity Recognition Using Smartphones Data Set, needs to be in a folder called "UCI HAR Dataset" in the working directory from which the script is run

###Reading Parameters for the training set
dfTrain - Holds data from the X_train.txt file which contains the X variable values for each activity in the tarining dataset
dfTrainActivity - Holds the different types of activities done during the experiment
dfTrainSubject - conatins id for subjects in the training datasets

Next step is joining all of these datasets to get a combined dataset with X and Y values for the training dataset using cbind

The final dataset is stored in dfTrain

###Reading Parameters for the test set
dfTest - Holds data from the X_test.txt file which contains the X variable values for each activity in the tarining dataset
dfTestActivity - Holds the different types of activities done during the experiment
dfTestubject - conatins id for subjects in the training datasets

Next step is joining all of these datasets to get a combined dataset with X and Y values for the test dataset using cbind

The final dataset is stored in dfTest

###Combining Train and test datasets
dfTrain and dfTest are combined using rbind to form a large dataset dfCombine

###Tidying up dfCombine
cSelCol - Stores all mean and std column names by using grep
cDefaultCols - Stores default columns like subject if and activity id
dfCombineTidy - contains all mean and standard deviation columns from the dataset as well as subjectid and activityid

###Getting Activity names corresponding to activityid
dfActivityLabels - Reads the activity_labels.txt file and stores the data in the dataframe
Next step is a left join of dfActivityLabels to dfCombineTidy, to get a descriptive column for activity

###Cleaning up variable names in dfCombineTidy
The next step is to convert the column names in dfCombineTidy to more meaningful labels
First store all columns names in dfCombineTidy in cColNamesTransform
Using regular expressions and sub function to find specific string and convert it into more meaningful titles.

###Getting average of variable values per subject per activity type
First import the dplyr package.
Store a copy of dfCombineTide in dfAvgTidy
Use dplyr pipe expression to froup by data in dfAvgTidy by subject, activity
Then summarize the data using mean./



