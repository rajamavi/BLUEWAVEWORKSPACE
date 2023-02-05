# CS422 Data Mining
# Vijay K. Gurbani, Ph.D.
# Illinois Institute of Technology

# Make sure you install these packages once by issuing the command:
# > install.packages(c("rpart", "rpart.plot", "caret", "e1071", "knitr", "ROCR"))

library(rpart)
library(caret)
library(rpart.plot)
library(ROCR)

rm(list=ls())

setwd("/home/vkg/IIT/CS422/lectures/lecture-5/")

options("digits"=3)

# Load the Diabetes dataset
diabetes <- read.csv("diabetes-mod.csv", header=T, sep=",", comment.char = '#')

# Split into 80-20 (train-test).
set.seed(100)
index <- sample(1:nrow(diabetes), size=0.2*nrow(diabetes))
test <- diabetes[index, ]
train <- diabetes[-index, ]

# Build the model using only two predictor variables.  I want you all to
# play around with building other models using all or a subset of the
# predictor variables.
#model <- rpart(label ~ preg + plas, method="class", data=train)
# You could specify all variables you want by using the following:
model <- rpart(label ~ ., method="class", data=train)

# Now visualize it
rpart.plot(model, extra=104, fallen.leaves = T, type=4, 
           main="Rpart on Diabetes data")

# More information about the model
print(model)  # or simply > model

# Run the prediction on the test dataset.
pred <- predict(model, test, type="class")

# How did we do?  Let's create a confusion matrix manually first.  Let's figure
# out how many observations in our test set were positive and negative.  These
# are the true labels.
total_pos <- sum(test[,9] == 1)
total_neg <- sum(test[,9] == 0)

# Now, let's see how many of the predicted observations that were positive
# actually matched the true labels.
tp <- sum(test[,9] == 1 & pred == 1)
tn <- sum(test[,9] == 0 & pred == 0)

table(test[, 9])  # Show real class distribution
table(pred)       # Show predicted class distribution
table(pred, test[,9]) # Manual confusion matrix
# Create the confusion matrix
confusionMatrix(pred, as.factor(test[, 9]))

# ROC curve
pred.rocr <- predict(model, newdata=test, type="prob")[,2]
f.pred <- prediction(pred.rocr, test$label)
f.perf <- performance(f.pred, "tpr", "fpr")
plot(f.perf, colorize=T, lwd=3)
abline(0,1)
auc <- performance(f.pred, measure = "auc")
auc@y.values[[1]]

## Pruned tree
#ptree <- prune(model, cp=model$cptable[which.min(model$cptable[,"xerror"]), "CP"])
#rpart.plot(ptree, extra=104, fallen.leaves = T, type=4)
#ptree.pred <- predict(ptree, test, type="class")
#confusionMatrix(ptree.pred, test[, 9])



