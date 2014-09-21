###This is script "run_analysis.R" for the Course Project. NKK - 09/20/2014
###Steps listed here (other than Step 0) correspond to the Steps listed in the Course Project Assignment.
###NOTE: Added column names in Step 0, before doing anything else with it - maintains the integrity of the data sets (my opinion)

## STEP 0 - Creating local directory, downloading, and extracting ".zip" files and naming columns.

# Creating local directory

if (!file.exists("Course_Project")) {
  dir.create("Course_Project")
}

# Downloading and unzipping files

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile="c:\\Get_Clean_Data\\Course_Project\\UCI_HAR_Dataset.zip")
dateDownload <- date()
unzip("c:\\Get_Clean_Data\\Course_Project\\UCI_HAR_Dataset.zip")

# Reading "test" and "features" files & naming columns

subject_test <- read.table("c:\\Get_Clean_Data\\UCI HAR Dataset\\test\\subject_test.TXT")
colnames(subject_test) <- c("subject_ID")

X_test <- read.table("c:\\Get_Clean_Data\\UCI HAR Dataset\\test\\X_test.TXT")
x_Colfile <- read.table("c:\\Get_Clean_Data\\UCI HAR Dataset\\features.TXT")  #Reading the file containing variable names
colnames(X_test) <- x_Colfile[ ,2] # Naming variable columns

y_test <- read.table("c:\\Get_Clean_Data\\UCI HAR Dataset\\test\\y_test.TXT")
colnames(y_test) <- c("activity_ID")

# Reading "train" files & naming columns

subject_train <- read.table("c:\\Get_Clean_Data\\UCI HAR Dataset\\train\\subject_train.TXT")
colnames(subject_train) <- c("subject_ID")

X_train <- read.table("c:\\Get_Clean_Data\\UCI HAR Dataset\\train\\X_train.TXT")
colnames(X_train) <- x_Colfile[ ,2] # Naming variable columns

y_train <- read.table("c:\\Get_Clean_Data\\UCI HAR Dataset\\train\\y_train.TXT")
colnames(y_train) <- c("activity_ID")

##STEP 1 - Merging "train" and "test" data sets

# Column Merging "test" files - Columns(Test Subject ID,Test Activity ID, Test Data)
TestDataset <- cbind.data.frame(subject_test,y_test,X_test)

# Column Merging "train" files - Columns(Train Subject ID,Train Activity ID, Train Data)
TrainDataset <- cbind.data.frame(subject_train,y_train,X_train)

# Row Merging "test" & "train" files
CombinedDataset <- rbind.data.frame(TestDataset,TrainDataset) # This resulted in 10299 obs. of 563 variables

## STEP 2 - Extracts only measurements on the mean and standard deviation for each measurement

step2ColExt <- grep("subject_ID|activity_ID|mean()|std()",names(CombinedDataset)) #Extracts the column #'s
step2datafinal <- CombinedDataset[ ,step2ColExt] #subsetting data. This resulted in 10299 obs. of 81 variables

## STEP 3 - Uses descriptive activity names to name the activities in the data set

activity_label <- read.table("c:\\Get_Clean_Data\\UCI HAR Dataset\\activity_labels.TXT")  #Reading the file containing activity labels
colnames(activity_label) <- c("activity_ID", "activity_label") # Adding column names to the activity labels file
step3data_merge <- merge(activity_label,step2datafinal,all=TRUE) # Merging by activity_ID
step3datafinal <- step3data_merge[ ,2:82] # Removes activity_ID
step3dataforstep4 <- step3datafinal # Creating a copy so if something goes wrong, I can start from Step3datafinal.

## STEP 4 - Appropriately labels the data set with descriptive variable names
## NOTE: Variable names were added in Step 0, before extracting mean() and std(). In STEP 4,
## the intend is to change (without going too crazy) the varible names to meet tidy data set standards.
## Eventhough tidy data "requires" all lower case variable names, I didn't follow this rule
## here because it makes the variable names difficult to read. Same with "-" and "_" in the variabe names.
## why do something that makes no sense?. Also, Didn't notice any "." or "space" in variable names. 

# Removing (), since it is there in all the variable names, and adds no additional information

step4data_col1 <- sub("\\()","",names(step3dataforstep4),)

# Replacing duplicate "BodyBody" in some variable names with "Body" and replacing with clean headers

colnames(step3dataforstep4) <- gsub("BodyBody","Body",step4data_col1,)

# Creating a copy of the final Step 4 data set and renaming for clarity

step4datafinal <- step3dataforstep4 # renaming for clarity

## STEP 5 - Creates from STEP 4 data set an independant tidy data set with the average of 
## each variable for each activity and each subject

# Loading plyr library
library(plyr)

# Getting average of varibles for each activity and each subject

step5result <- ddply(step4datafinal,c(.(activity_label),.(subject_ID)),numcolwise(mean)) # View this file in R for clean look of the table.

# The above script resulted in a file "step5result" with 180 obs. of 81 variables. (i.e. 6 activity types x 30 subjects = 180 obs.);
# 81 variables includes "activity_labels", and "subject_ID" and 78 variables (including "meanFreq" variables)

# Writing to a ".TXT" file uploading. Use Notepad++ to view the file on your computer

write.table(step5result, file="c:\\Get_Clean_Data\\Course_Project\\step5result.TXT", col.names =TRUE,row.names=FALSE)

## file "step5result.TXT" uploaded. Use Notepad++ for a better viewing experience :)