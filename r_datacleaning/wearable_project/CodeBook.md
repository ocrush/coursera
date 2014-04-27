Variables:
features      - data frame with feature information.
idx           - indices of features that match -mean() and -std().
aLabels       - Activity labels
trainData     - training data with subject, activity_code, activity, and mean/std measurements
testData      - test data with subject, activity_code, activity, and mean/std measurements
mergeData     - merge of both train and test data.
tidyDataMelt  - melt of merge data according to subject and activity
tidyData      - average of each variable for each activity and
                 each subject. 
				 
The data was contained in multiple files that needed to be combined to create desired data frame.

The steps taken to combine and clean data are as follows:
1. From the features file retreive the indices for matching mesurements (mean(), std()). Here the use of grep was made
   to match feature names.
2. In order to have description for activity_code, needed to read the mapping of activity code to labels from the 
   activity labels.
3. Used column bind to append data to the data frame. Intially created DF with subject and added columns for activity and 
   measuments.  Reading of measuments is costly as it is reading all columns ionto memory and then sub-setting.  It would
   be nice to only read the required columns.
4. Same was done for test data.
5. The training nad test data is merged using the merge function.
6. The tidyData is created by using the melt function in the reshape2 package and then using the dcast to reshape/summarize
   the data.