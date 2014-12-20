Coursera_Getting_and_cleaning_data
==================================

Course Project for the Coursera Getting and Cleaning Data Course.

The script downloads the data in a newly created (unless it exists already) "data" folder in the working directory,
unzips the files, and then reads the files of interest within the main folder for the description of features and activities,
and within each folder "train" and "test" for the files including the actual measurements (Xtrain.txt and Xtest.txt), the 
activities coded 1 to 6 (ytrain.txt and ytest.txt), and the subject ids (coded 1 to 30).

In a first step, the train and test datasets are merged.

Then, the scripts selects in a second step among all features only the ones that are mean or std measures.

In a third step, the name of activities are added in an extra column called "activity_name"

In a fourth step, the variables are given their names as defined in the features.txt file.

Finally, the fifth step summarizes the multiple measurements for each individual, type of activity and feature to only retain the mean of the measurements.
This final table is written as a txt file (tab separated).



What's in the data called "step5"?
        This file was created as part of the Course assignment for the Coursera Getting and cleaning Data.
        The goal was to take data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones,
        to merge the train and test datasets, and extract some of the features and to summarize for each of the 30 patients,
        and 6 activities.
        
        1. The first column called "subject" has the id of the subject (between 1 and 30).
        
        2. The second column called "activity" has the type of activity the subject was ongoing (1 in 6 activity types: LAYING, SITTING, 
        STANDING, WALKING.DOWNSTAIRS, WALKING.UPSTAIRS, or WALKING.
        
        Then columns 3 to 68 have each one of 66 features described below. The values represent the means for each feature per subject and activity type.
        
        Feature Selection 
        =================
        
        The features selected come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
        
        These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
        
        Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz 
        to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals 
        (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
        
        Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
        
        Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
        
        These signals were used to estimate variables of the feature vector for each pattern:  
        '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
        
        Only the mean and standard deviation were considered here.
        
        License:
        ========
        Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
        
        [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
        
        This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
        
        Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
