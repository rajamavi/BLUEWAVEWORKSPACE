# Titanic.r: The TITANIC dataset and decision trees.
#
# Vijay K. Gurbani, Ph.D.
# Dept. of Computer Science, Illinois Institute of Technology
# CS 422

rm(list=ls())
library(rpart)
library(caret)
library(rpart.plot)
library(ROCR)

# sibsp: No. of sibling and spouses aboard
# parch: Number of parents/children aboard
# pclass: Ticket class  --> Used for modeling
# embarked: Port of embarkation: C = Cherbourg, Q = Queenstown, S = Southampton
# sex: Sex of passenger --> Used for modeling
# age: Age of passenger --> Used for modeling
# ... There are other variables in the dataset not listed above.  We use only
# three (indicated above) for modeling.

set.seed(100)
setwd("/home/vkg/IIT/CS422/lectures/lecture-5")

data <- read.csv("./titanic-new.csv", sep=",", header=T)

index <- sample(1:nrow(data), size=0.4*nrow(data))

test <- data[index, ]
train <- data[-index, ]

model <- rpart(survived ~ pclass + sex + age, method="class", data=train)

rpart.plot(model, extra=104, fallen.leaves=T, type=4, 
           main="Titanic Survival Model")

print(model)

# Run predictions
pred <- predict(model, test, type="class")
pred.prob <- predict(model, test, type="prob")

# Let's create a confusion matrix and see how well we did
confusionMatrix(pred, as.factor(test$survived))

# Calculate AUC and plot ROC
rocr <- predict(model, newdata=test, type="prob")[,2]
f.pred <- prediction(rocr, test$survived)
plot(performance(f.pred, "tpr", "fpr"), colorize=T, lwd=3)
abline(0,1)

# Print AUC
auc.pruned <- performance(f.pred, measure = "auc")
cat(paste("The area under curve (AUC) for the full tree is ", 
          round(auc.pruned@y.values[[1]], 3)))


# Pruning the tree
printcp(model)
plotcp(model)
cpx <- model$cptable[which.min(model$cptable[,"xerror"]), "CP"]
pruned.model <- prune(model, cp=cpx)

# Run predictions on the pruned model
pred <- predict(pruned.model, test, type="class")

# Let's create a confusion matrix and see how well we did
confusionMatrix(pred, as.factor(test$survived))
