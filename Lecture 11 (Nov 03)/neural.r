# Neural network demonstration
# Source: # https://tensorflow.rstudio.com/keras/articles/tutorial_basic_classification.html
library(keras)
library(tidyr)
library(ggplot2)

# Load the dataset and split into train (60K images) and test (10K images).
fashion_mnist <- dataset_fashion_mnist()

c(train_images, train_labels) %<-% fashion_mnist$train
c(test_images, test_labels) %<-% fashion_mnist$test

class_names = c('T-shirt/top',
                'Trouser',
                'Pullover',
                'Dress',
                'Coat', 
                'Sandal',
                'Shirt',
                'Sneaker',
                'Bag',
                'Ankle boot')

# Process the data
train_images <- train_images / 255
test_images <- test_images / 255

# Draw the first 25 images from the training dataset
par(mfcol=c(5,5))
par(mar=c(0, 0, 1.5, 0), xaxs='i', yaxs='i')
for (i in 1:25) { 
  img <- train_images[i, , ]
  img <- t(apply(img, 2, rev)) 
  image(1:28, 1:28, img, col = gray((0:255)/255), xaxt = 'n', yaxt = 'n',
        main = paste(class_names[train_labels[i] + 1]))
}

# Build the neural network
model <- keras_model_sequential()
model %>%
  layer_flatten(input_shape = c(28, 28)) %>%
  layer_dense(units = 128, activation = 'relu') %>%
  layer_dense(units = 10, activation = 'softmax')

# Compile it
model %>% compile(
  optimizer = 'adam', 
  loss = 'sparse_categorical_crossentropy',
  metrics = c('accuracy'))
  
# Train it
model %>% fit(train_images, train_labels, epochs = 20, validation_split=0.30)

# Make predictions
predictions <- model %>% predict(test_images)

# Get the per-class predictions
# class_pred <- model %>% predict(test_images) %>% k_argmax()
class_pred <- model %>% predict(test_images)
class_pred[1:20]

# Functions --------------------------------------------
display_image <- function(idx) {
  image_1 <- as.data.frame(test_images[idx, , ])
  colnames(image_1) <- seq_len(ncol(image_1))
  image_1$y <- seq_len(nrow(image_1))
  image_1 <- gather(image_1, "x", "value", -y)
  image_1$x <- as.integer(image_1$x)
  
  ggplot(image_1, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_gradient(low = "white", high = "black", na.value = NA) +
    scale_y_reverse() +
    theme_minimal() +
    theme(panel.grid = element_blank())   +
    theme(aspect.ratio = 1) +
    xlab("") +
    ylab("")
}
#------------------------------------------------------------------------------
predict_image <- function(indx) {
  #print(display_image(indx))
  #readline(prompt="Hit <enter to continue")
  cat(paste("Predictions:\n"))
  cat(round(predictions[indx, ], 3))
  #readline(prompt="Hit <enter to continue")

  # From before
  #i <- class_pred[indx]; class_names[i+1]
  #cat(paste("\nClass of predicted image:", class_pred[indx], "(", class_names[i+1], ")\n"))
  
  i <- which.max(class_pred[indx,])
  cat(paste("\nClass of predicted image:", i, "(", 
            class_names[i], ")\n"))

  #readline(prompt="Hit <enter to continue")
  i <- test_labels[indx]
  cat(paste("Class of actual image:", test_labels[indx]+1, "(", 
            class_names[i+1], ")\n"))
  #readline(prompt="Hit <enter to continue")
}