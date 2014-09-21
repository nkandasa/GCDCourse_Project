==============================================================================================
This README.md file describes the data processing steps taken to create "step5result.TXT" file 
using "run_analysis.R" script. Version Date: 09/20/2014
==============================================================================================

The run_analysis.R" script follows the same sequence of steps required for the course project, with the exception of an additional STEP 0. 

STEP 0:

Included Step 0 for creating local directory, downloading, and extracting ".zip" files and naming columns. Note that column names are added in this step to maintain the integrity of the data sets. "unzip" function used to extract folders and files. 

Reading "test","train and "features" files and naming of columns was done at this stage so that "train" and "test" data sets are defined prior to being combined. This eliminates potential problems when binding files with inconsistent rows or columns after subsetting. 


STEP 1: 

Merging "train" and "test" data sets using "cbind" and "rbind" function. This resulted in 10299 obs. of 563 variables. 563 variables includes "activity_ID" and "subject_ID" and all the measurments.


STEP 2: 

Extracts only measurements on the mean and standard deviation for each measurement. "grep" function was used to select column variables that contained "mean()" and "std()". Included variable that had "meanFreq" as well. 

Subsetting resulted in 10299 obs. of 81 variables - including "activity_ID" and "subject_ID" and 79 "mean" and "std" measurements. 


"step2datafinal" data frame created. 


STEP 3: 

Uses descriptive activity names to name the activities in the data set. Read the file containing activity labels, merged it with the data set from STEP 2 then removed "activity_ID" column. 

"step3datafinal" data frame created. 


Created a copy of"step3datafinal" for use in STEP 4, so that if something goes wrong, I don't have to start from scratch.


STEP 4: 

Appropriately labels the data set with descriptive variable names. Variable names were added in Step 0, before extracting mean() and std(). In STEP 4, the intent is to change (without going too crazy) the variable names to meet tidy data set standards.

Even though tidy data "requires" all lower case variable names, I didn't follow this rule here because it makes the variable names difficult to read. Same with no "-" and "_" in the variable names rule. Also, didn't notice any "." or "space" in variable names, so only the following changes were made to the variable names.

1. Removed (), since it is there in all the variable names, and adds no additional information
2. Replaced duplicate "BodyBody" in some variable names with "Body"

'step4datafinal" data frame created. 


STEP 5:

Creates from STEP 4 data set an independent tidy data set with the average of each variable for each activity and each subject

Loaded plyr library and used "ddply" function to get averages of measurements. "step5result" created. view this file in R for clean look of the table.


Step5 resulted in a file "step5result" with 180 obs. of 81 variables. (i.e. 6 activity types x 30 subjects = 180  
obs.). 81 variables includes "activity_labels", and "subject_ID" and 78 variables (including "meanFreq" variables)

Wrote to a "step5result.TXT" file for uploading, using "write.table" function with row.names=FALSE argument. file "step5result.TXT" can be best viewed in Notepad++. 

All step required by the course assignment after Step5.



Files included in Github Repo

"README.md" - This file

"run_analysis.R" - code used to create "step5result.TXT" file.

"CodeBook.TXT" - Data dictionary for "step5result.TXT" file.

"step5result.TXT" - Tidy data output submitted for Part 1. 



**********************************************ORIGINAL README FILE PROVIDED FOR REFERENCE **********************************
****************************************************************************************************************************


==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
