# Main driver for the neural network
setwd("/home/vkg/IIT/CS422/lectures/neural-networks/")
library(keras)
library(tidyr)
library(ggplot2)

options(scipen=999) # Turns scientific notation off
options(digits = 4)

rm(list=ls())

source("neural.r")

# Model has been trained, let's see how it performs.
# Set a random index into the test set.  Some examples:
# 1024, 32, 2048, 734, 788 (error), 961 (error)
display_image(1024)
predict_image(1024)

# Class   Object
#   0     T-shirt/top
#   1     Trouser
#   2     Pullover
#   3     Dress
#   4     Coat 
#   5     Sandal
#   6     Shirt
#   7     Sneaker
#   8     Bag
#   9     Ankle boot