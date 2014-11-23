## Project file for R Getting/Cleaning Data course on Coursera
##
## See description_to_do for basic outline of what needs to be done in analysis

## Merges training/test data sets and returns them as a data frame
mergeTrainingTest <- function(){
  
  neededPkgs <- list("dplyr","tidyr")
  startWd    <- getwd()
  sapply(neededPkgs,function(pkg){
    if (!require(pkg,character.only=TRUE)){
      stop("Could not load ",pkg,call.=FALSE)
    }
  })
    
  if (!"UCI HAR Dataset" %in% list.files()){
    stop("UCI Dataset not found - check working directory")
  }
  
  # Load list of feature names
  setwd("UCI HAR Dataset")
  
  activities <- read.table(file="activity_labels.txt",
                                  col.names=c("number","activity_name"),
                                  colClasses=c("numeric","character"))
  
  features <- read.table(file="features.txt",
                                col.names=c("feature_number","name"),
                                colClasses=c("numeric","character"),
                                stringsAsFactors=FALSE)  
  
  ## Load training data first
  setwd("train/")
  trainobs <- read.table(file="X_train.txt",
                         colClasses="numeric",
                         stringsAsFactors=FALSE)
  
  names(trainobs) <- features$name
  
  trainactivities <- read.table(file="y_train.txt",
                                colClasses="numeric",
                                col.names=c("activities"))
  
  # Merge activity names as a new column in trainobs
  trainobs <- cbind(trainobs,
                    as.factor(activities[trainactivities$activities,2][[1]]))
  
  names(trainobs)[ncol(trainobs)] <- "activity_names"
  
  # Load data about people who performed observations into file
  trainsubjects <- read.table(file="subject_train.txt",
                              colClasses="numeric",
                              col.names=c("Subject_ID"))
  
  trainobs <- cbind(trainobs,trainsubjects)
  
  ## Load testing data next
  setwd("../test")
  
  testobs <- read.table(file="X_test.txt",
                         colClasses="numeric",
                         stringsAsFactors=FALSE)
  
  names(testobs) <- features$name
  
  testactivities <- read.table(file="y_test.txt",
                               colClasses="numeric",
                               col.names=c("activities"))
  
  testsubjects <- read.table(file="subject_test.txt",
                             colClasses="numeric",
                             col.names=c("Subject_ID"))
  
  testobs <- cbind(testobs,
                   as.factor(activities[testactivities$activities,2][[1]]),
                   testsubjects)
  
  names(testobs)[ncol(testobs)-1] <- "activity_names"
  
  # Restore original directory
  setwd(startWd)
  
  return(tbl_df(rbind(trainobs,testobs)))
}

## From the combined test/train data, return only the standard deviation / mean
## measurements.  (With exception being made for subject ID and activity type).
extractOnlyMeanStdDev <- function(){
  #TODO: Implementation
}

## From the combined data (only std devs and averages) - return tidied dataset
tidyData <- function(){
  #TODO: Implementation
}
  