run_analysis.R - main script to create merge of train and test data.  In addition, it 
                 creates a tidy data with average of each variable for each activity and
                 each subject.
Overview
The script assumes that the data has been downloaded and the script is executed from the data directory.

This script starts out by creating two different data frames.  The trainData data frame contains the subject, activity, and 
measuments on mean and std deviation.  Same for testData.  Next, the both data frames are combined to create mergeData.  The 
mergeData is melted and reshaped/summarized to retreive tidy data with with average of each variable for each activity and 
each subject. 

CodeBook.md - Details on run_analysis script.


Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed 
six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at 
a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding 
windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion 
components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed 
to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features
was obtained by calculating variables from the time and frequency domain. 

Source:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - Universit√  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition '@' smartlab.ws 
www.smartlab.ws 