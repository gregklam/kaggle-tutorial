#Set Working Directory
setwd("~/Dropbox/Personal Data Projects/Kaggle Titanic Tutorial")

#Import Libraries
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

#Read in the Training and Testing Datasets
trainData <- read.csv("train.csv", header = TRUE, stringsAsFactors = FALSE)
testData <- read.csv("test.csv", header = TRUE, stringsAsFactors = FALSE)

#Explore the format of the dataset using head()
head(trainData)

#Build a Decision Tree using the rpart package
#Predict whether or not a person survives using the following variables:
#Sex, Age, Number of Siblings/Spouses Aboard, Number of Parents/Children Aboard, Passenger Fare, and Port of Embarkation
my_tree<- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=trainData, method = "class")

#Create the Data Tree Visualization
fancyRpartPlot(my_tree)

#Apply Decision Tree Algorithm to test Dataset
my_prediction <- predict(my_tree, testData, type="class")

#Create 2 column data frame with PassangerId and Survived, which contain predictions
my_solution <- data.frame(PassengerId = testData$PassengerId, Survived = my_prediction)

#Write solution to csv file with name decision_tree_solution.csv
write.csv(my_solution, file="decision_tree_solution.csv", row.names = F)
