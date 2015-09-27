library(plyr)
library(dplyr)

## It is not necessary to initialize directory, since the data file should be copied to the working directory
## Note that the "test" and "train" files must be located in the corresponding subdirectories

## reading description files
activities <- read.csv("activity_labels.txt",header=FALSE,sep="")
names(activities) <- c("id_act","activity")
features <- read.csv("features.txt",  sep= "",header = FALSE)

## reading test files
x_test <- read.csv("test/X_test.txt",header=FALSE,sep="")
activity_test <- read.csv("test/y_test.txt",header=FALSE,sep="")
subject_test <- read.csv("test/subject_test.txt",header=FALSE,sep="")
names(x_test) <- features$V2
x_test [,"id_act"] <- activity_test
x_test [,"subject"] <- subject_test
x_test <- join(x_test,activities,by="id_act")
x_test [,"stage"] <- rep("test",nrow(x_test))
x_test <- x_test[,c("stage","subject","id_act","activity",
                     setdiff(names(x_test),c("activity","id_act","subject","stage")))]

## reading train files
x_train <- read.csv("train/X_train.txt",header=FALSE,sep="")
activity_train <- read.csv("train/y_train.txt",header=FALSE,sep="")
subject_train <- read.csv("train/subject_train.txt",header=FALSE,sep="")
names(x_train) <- features$V2
x_train [,"id_act"] <- activity_train
x_train [,"subject"] <- subject_train
x_train <- join(x_train,activities,by="id_act")
x_train [,"stage"] <- rep("train",nrow(x_train))
x_train <- x_train[,c("stage","subject","id_act","activity",
                      setdiff(names(x_train),c("activity","id_act","subject","stage")))]

## merge data sets
x_onedataset <- rbind(x_train,x_test)

## subsetting to pick only mean() and std()
features_subset <- features[(grepl("-mean()",features$V2)) | (grepl("-std()",features$V2)),]
x_subset <- x_onedataset[,c("stage","subject","activity",intersect(names(x_onedataset),features_subset$V2))]

## "group by" and "summarise" to calculate mean per subject, activity and feature
mean_table_total <- data.frame()
miniset <- data.frame(matrix(0,nrow=nrow(x_subset),ncol=4))
names(miniset) <- c("subject","activity","feature","value")

first_feature <- 4
last_feature <- 82
for (j in first_feature:last_feature)
{
  for (k in 1:nrow(x_subset))
  {
    miniset [k,1] <- x_subset[k,2]
    miniset [k,2] <- x_subset[k,3]
    miniset [k,3] <- names(x_subset)[j]
    miniset [k,4] <- x_subset[k,j]
  }
  grupo<-group_by(miniset,subject,activity,feature)
  mean_table <- summarise(grupo,media=mean(value))
  mean_table_total<-rbind(mean_table_total,mean_table)
}

names(activities) <- c("activity","activity_name")
mean_table_total <- join(mean_table_total,activities,by="activity")
mean_table_total$activity<-NULL
mean_table_total<-mean_table_total[c(1,4,2,3)]

